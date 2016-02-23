using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using UnityEngine;

namespace Assets.Scripts
{
    public class LightManager
    {
        private const float CELL_SIZE = Cave.CELL_SIZE;

        private float LightEdgesIntersect(LightEdge a, LightEdge b)
        {
            float ua, ub, ud, ux, uy, vx, vy, wx, wy;
            ua = 0.0f;
            ux = a.x2 - a.x1;
            uy = a.y2 - a.y1;
            vx = b.x2 - b.x1;
            vy = b.y2 - b.y1;
            wx = a.x1 - b.x1;
            wy = a.y1 - b.y1;
            ud = vy * ux - vx * uy;

            if (ud != 0)
            {
                ua = (vx * wy - vy * wx) / ud;
                ub = (ux * wy - uy * wx) / ud;
                if (ua < 0 || ua > 1 || ub < 0 || ub > 1)
                {
                    ua = 0;
                }
            }
            return ua;
        }

        private float DistancePointToEdge(float x, float y, LightEdge e)
        {
            float x1 = e.x1;
            float y1 = e.y1;
            float x2 = e.x2;
            float y2 = e.y2;

            float A = x - x1;
            float B = y - y1;
            float C = x2 - x1;
            float D = y2 - y1;

            float dot = A * C + B * D;
            float len_sq = C * C + D * D;
            float param = -1.0f;
            if (len_sq != 0)
            {
                param = dot / len_sq;
            }

            float xx, yy;

            if (param < 0)
            {
                xx = x1;
                yy = y1;
            }
            else if (param > 1)
            {
                xx = x2;
                yy = y2;
            }
            else
            {
                xx = x1 + param * C;
                yy = y1 + param * D;
            }

            var dx = x - xx;
            var dy = y - yy;
            return Mathf.Sqrt(dx * dx + dy * dy);
        }

        private void GetLightEdges(Rect bounds, float x, float y)
        {
            PriorityQueue<LightEdge> edges = new PriorityQueue<LightEdge>();

            float leftX = bounds.x;
            float rightX = bounds.x + bounds.width;
            float topY = bounds.y;
            float botY = bounds.y - bounds.height;

            // create bounding edges
            LightEdge top = new LightEdge(leftX, topY, rightX, topY);
            top.distance = DistancePointToEdge(x, y, top);
            LightEdge bot = new LightEdge(rightX, botY, leftX, botY);
            bot.distance = DistancePointToEdge(x, y, bot);
            LightEdge left = new LightEdge(leftX, botY, leftX, topY);
            left.distance = DistancePointToEdge(x, y, left);
            LightEdge right = new LightEdge(rightX, topY, rightX, botY);
            right.distance = DistancePointToEdge(x, y, right);
            top.prev = left;
            top.next = right;
            right.prev = top;
            right.next = bot;
            bot.prev = right;
            bot.next = left;
            left.prev = bot;
            left.next = top;
            edges.Enqueue(top);
            edges.Enqueue(bot);
            edges.Enqueue(left);
            edges.Enqueue(right);

            // find all edges facing (x, y) in the bounds
            for (int r = (int)Mathf.Floor(Mathf.Abs(topY) / CELL_SIZE); r < (int)Mathf.Floor(Mathf.Abs(botY) / CELL_SIZE); r++)
            {
                for (int c = (int)Mathf.Floor(leftX / CELL_SIZE); c < (int)Mathf.Floor(rightX / CELL_SIZE); c++)
                {
                    if (r >= 0 && c >= 0 && r < Cave.CAVE_WIDTH && c < Cave.CAVE_HEIGHT)
                    {
                        LightEdge e = GetCellEdgeFacingPoint(c, r, x, y);
                        if (e != null)
                        {
                            e.distance = DistancePointToEdge(x, y, e);
                            edges.Enqueue(e);
                        }
                    }
                }
            }

            // set next and previous edge values
            foreach(LightEdge a in edges.getData())
            {
                foreach (LightEdge b in edges.getData())
                {
                    if (!a.Equals(b))
                    {
                        if (a.x1 == b.x2 && a.y1 == b.y2)
                        {
                            a.prev = b;
                            b.next = a;
                        }
                        else if (a.x2 == b.x1 && a.y2 == b.y1)
                        {
                            a.next = b;
                            b.prev = a;
                        }
                    }
                }
            }

            // edge projections
            foreach (LightEdge e in edges.getData())
            {
                if (e.prev == null)
                {
                    // TODO
                }
                if (e.next == null)
                {
                    // TODO
                }
            }


        }

        private LightEdge GetCellEdgeFacingPoint(int c, int r, float x, float y)
        {
            float top = -r * CELL_SIZE;
            float bot = -(r + 1) * CELL_SIZE;
            float left = c * CELL_SIZE;
            float right = (c + 1) * CELL_SIZE;

            switch (Cave.grid[c, r])
            {
                case Cell.EdgeE:
                    if (x > right)
                    {
                        return new LightEdge(right, top, right, bot);
                    }
                    break;
                case Cell.EdgeW:
                    if (x < left)
                    {
                        return new LightEdge(left, bot, left, top);
                    }
                    break;
                case Cell.EdgeN:
                    if (y > top)
                    {
                        return new LightEdge(left, top, right, top);
                    }
                    break;
                case Cell.EdgeS:
                    if (y < bot)
                    {
                        return new LightEdge(right, bot, left, bot);
                    }
                    break;
                case Cell.SlantNE:
                    if (y < top - left + x)
                    {
                        return new LightEdge(right, bot, left, top);
                    }
                    break;
                case Cell.SlantSW:
                    if (y > top - left + x) // conditional might be switched with SlantSE...
                    {
                        return new LightEdge(left, top, right, bot);
                    }
                    break;
                case Cell.SlantNW:
                    if (y < right + top - x)
                    {
                        return new LightEdge(right, top, left, bot);
                    }
                    break;
                case Cell.SlantSE:
                    if (y > right + top - x)
                    {
                        return new LightEdge(bot, left, top, right);
                    }
                    break;
            }

            return null;
        }
    }
}

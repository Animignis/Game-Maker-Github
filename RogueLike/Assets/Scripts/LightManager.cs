using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using UnityEngine;

namespace Assets.Scripts
{
    public class LightManager : MonoBehaviour
    {
        private const float CELL_SIZE = Cave.CELL_SIZE;
        private Texture2D lightTexture;
        private Texture2D clearLightTexture;
        private Color32[] clearPixels;

        public Camera camera;
        public GameObject player;

        public bool active = true;

        void Start()
        {
            player = GameObject.Find("Player");
            camera = GameObject.Find("MainCamera").GetComponent<Camera>();
            lightTexture = new Texture2D(camera.pixelWidth, camera.pixelHeight);
            clearLightTexture = new Texture2D(camera.pixelWidth, camera.pixelHeight);

            Debug.Log(camera.pixelWidth);
            Debug.Log(camera.pixelHeight);

            clearPixels = new Color32[camera.pixelWidth * camera.pixelHeight];
            for (int i = 0; i < clearPixels.Length; i++)
            {
                clearPixels[i] = Color.clear;
            }
            clearLightTexture.SetPixels32(clearPixels);
            clearLightTexture.Apply();

            lightTexture.SetPixels32(clearPixels);
            lightTexture.Apply();

            lightTexture.wrapMode = TextureWrapMode.Clamp;
        }

        void FixedUpdate()
        {
            if (active)
            {
                float height = 2f * camera.orthographicSize;
                float width = height * camera.aspect;
                Vector3 pos = camera.transform.position;

                lightTexture.SetPixels32(clearPixels);
                GetLightEdges(new Rect(pos.x - width / 2, pos.y - height / 2, width, height), player.transform.position.x, player.transform.position.y);
            }

            if (Input.GetKey(KeyCode.L))
            {
                active = !active;
            }
            
        }

        void OnGUI()
        {
            GUI.DrawTexture(new Rect(0, 0, camera.pixelWidth, camera.pixelHeight), lightTexture);
        }

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

        public void GetLightEdges(Rect bounds, float x, float y)
        {
            PriorityQueue<LightEdge> edges = new PriorityQueue<LightEdge>();

            float leftX = bounds.x;
            float rightX = bounds.x + bounds.width;
            float botY = bounds.y;
            float topY = bounds.y + bounds.height;

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
            for (int r = (int)Mathf.Floor(botY / CELL_SIZE); r <= (int)Mathf.Floor(topY / CELL_SIZE); r++)
            {
                for (int c = (int)Mathf.Floor(leftX / CELL_SIZE); c <= (int)Mathf.Floor(rightX / CELL_SIZE); c++)
                {
                    if (r <= 0 && c >= 0 && r > -Cave.CAVE_WIDTH && c < Cave.CAVE_HEIGHT)
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
            
            foreach(LightEdge e in edges.getData())
            {
                // set next and previous edge values
                foreach (LightEdge b in edges.getData())
                {
                    if (!e.Equals(b))
                    {
                        if (e.x1 == b.x2 && e.y1 == b.y2)
                        {
                            e.prev = b;
                            b.next = e;
                        }
                        else if (e.x2 == b.x1 && e.y2 == b.y1)
                        {
                            e.next = b;
                            b.prev = e;
                        }
                    }
                }

                // set projections
                if (e.prev == null)
                {
                    Vector2 dir = new Vector2(e.x1 - x, e.y1 - y);
                    Vector2 line = dir.normalized * camera.orthographicSize * 2f;
                    LightEdge proj = new LightEdge(e.x1 + line.x, e.y1 + line.y, e.x1, e.y1);
                    proj.next = e;
                    e.prev = proj;

                    DrawLightEdge(proj, Color.red);

                    // TODO: intersection logic
                }
                if (e.next == null)
                {
                    Vector2 dir = new Vector2(e.x2 - x, e.y2 - y);
                    Vector2 line = dir.normalized * camera.orthographicSize * 2f;
                    LightEdge proj = new LightEdge(e.x2, e.y2, e.x2 + line.x, e.y2 + line.y);
                    proj.prev = e;
                    e.next = proj;

                    DrawLightEdge(proj, Color.red);

                    // TODO: intersection logic
                }

                DrawLightEdge(e, Color.red);
            }

            DrawLightEdge(edges.Peek(), Color.cyan);
            
            lightTexture.Apply();
        }

        private void DrawLightEdge(LightEdge e, Color col)
        {
            // debug light edges
            Vector3 p0 = camera.WorldToScreenPoint(new Vector3(e.x1, e.y1, 0));
            Vector3 p1 = camera.WorldToScreenPoint(new Vector3(e.x2, e.y2, 0));
            DrawLine(lightTexture, (int)p0.x, (int)p0.y, (int)p1.x, (int)p1.y, col);
            if (e.prev == null)
            {
                DrawLine(lightTexture, (int)p0.x - 5, (int)p0.y - 5, (int)p0.x + 5, (int)p0.y + 5, Color.green);
            }
            if (e.next == null)
            {
                DrawLine(lightTexture, (int)p1.x + 5, (int)p1.y - 5, (int)p1.x - 5, (int)p1.y + 5, new Color(0.5f, 0.2f, 1, 1));
            }
        }

        private LightEdge GetCellEdgeFacingPoint(int c, int r, float x, float y)
        {
            float top = (r+1) * CELL_SIZE;
            float bot = r * CELL_SIZE;
            float left = c * CELL_SIZE;
            float right = (c+1) * CELL_SIZE;
            float b = 0;

            switch (Cave.grid[c, -r])
            {
                case Cell.EdgeE:
                    if (x > right)
                    {
                        return new LightEdge(right, bot, right, top);
                    }
                    break;
                case Cell.EdgeW:
                    if (x < left)
                    {
                        return new LightEdge(left, top, left, bot);
                    }
                    break;
                case Cell.EdgeN:
                    if (y > top)
                    {
                        return new LightEdge(right, top, left, top);
                    }
                    break;
                case Cell.EdgeS:
                    if (y < bot)
                    {
                        return new LightEdge(left, bot, right, bot);
                    }
                    break;
                
                case Cell.SlantNE:
                    b = left + top;
                    if (y > -x + b)
                    {
                        return new LightEdge(right, bot, left, top);
                    }
                    break;
                
                case Cell.SlantSW:
                    b = left + top;
                    if (y < -x + b)
                    {
                        return new LightEdge(left, top, right, bot);
                    }
                    break;
                
                case Cell.SlantNW:
                    b = bot - left;
                    if (y > x + b)
                    {
                        return new LightEdge(right, top, left, bot);
                    }
                    break;
                case Cell.SlantSE:
                    b = bot - left;
                    if (y < x + b)
                    {
                        return new LightEdge(left, bot, right, top);
                    }
                    break;
            }

            return null;
        }

        private void DrawLine(Texture2D tex, int x0, int y0, int x1, int y1, Color col)
        {
            int dy = (int)(y1 - y0);
            int dx = (int)(x1 - x0);
            int stepx, stepy;

            if (dy < 0) { dy = -dy; stepy = -1; }
            else { stepy = 1; }
            if (dx < 0) { dx = -dx; stepx = -1; }
            else { stepx = 1; }
            dy <<= 1;
            dx <<= 1;

            float fraction = 0;

            tex.SetPixel(x0, y0, col);
            if (dx > dy)
            {
                fraction = dy - (dx >> 1);
                while (Mathf.Abs(x0 - x1) > 1)
                {
                    if (fraction >= 0)
                    {
                        y0 += stepy;
                        fraction -= dx;
                    }
                    x0 += stepx;
                    fraction += dy;
                    tex.SetPixel(x0, y0, col);
                }
            }
            else
            {
                fraction = dx - (dy >> 1);
                while (Mathf.Abs(y0 - y1) > 1)
                {
                    if (fraction >= 0)
                    {
                        x0 += stepx;
                        fraction -= dy;
                    }
                    y0 += stepy;
                    fraction += dx;
                    tex.SetPixel(x0, y0, col);
                }
            }
        }

    }
}

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

        public Camera cam;
        public GameObject player;

        public bool active = true;

        void Start()
        {
            player = GameObject.Find("Player");
            cam = GameObject.Find("MainCamera").GetComponent<Camera>();
            lightTexture = new Texture2D(cam.pixelWidth, cam.pixelHeight);
            clearLightTexture = new Texture2D(cam.pixelWidth, cam.pixelHeight);

            Debug.Log(cam.pixelWidth);
            Debug.Log(cam.pixelHeight);

            clearPixels = new Color32[cam.pixelWidth * cam.pixelHeight];
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
                float height = 2f * cam.orthographicSize;
                float width = height * cam.aspect;
                Vector3 pos = cam.transform.position;

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
            GUI.DrawTexture(new Rect(0, 0, cam.pixelWidth, cam.pixelHeight), lightTexture);
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

            float leftX = Mathf.FloorToInt(bounds.x);
            float rightX = Mathf.FloorToInt(bounds.x + bounds.width) + 1;
            float botY = Mathf.FloorToInt(bounds.y);
            float topY = Mathf.FloorToInt(bounds.y + bounds.height) + 1;

            // find all edges facing (x, y) in the bounds
            int leftCol = Mathf.FloorToInt(leftX / CELL_SIZE);
            leftCol = Mathf.Clamp(leftCol, 0, Cave.grid.GetLength(0) - 1);
            int rightCol = Mathf.FloorToInt(rightX / CELL_SIZE) - 1;
            rightCol = Mathf.Clamp(rightCol, 0, Cave.grid.GetLength(0) - 1);
            int topRow = Mathf.FloorToInt(topY / CELL_SIZE) - 1;
            topRow = Mathf.Clamp(topRow, -Cave.grid.GetLength(1) + 1, 0);
            int botRow = Mathf.FloorToInt(botY / CELL_SIZE);
            botRow = Mathf.Clamp(botRow, -Cave.grid.GetLength(1) + 1, 0);

            // false means searching for end point
            // true means searching for start point
            bool firstIteration = true;
            for (int r = botRow; r <= topRow; r++)
            {
                #region Set Left and Right Boundary Edges
                Cell leftCell = Cave.grid[leftCol, -r];
                if (leftCell == Cell.Empty || leftCell == Cell.SlantSW || leftCell == Cell.SlantNW)
                {
                    LightEdge e = new LightEdge(leftCol, r, leftCol, r + 1);
                    e.distance = DistancePointToEdge(x, y, e);
                    edges.Enqueue(e);
                }

                Cell rightCell = Cave.grid[rightCol, -r];
                if (rightCell == Cell.Empty || rightCell == Cell.SlantSE || rightCell == Cell.SlantNE)
                {
                    LightEdge e = new LightEdge(rightX, r + 1, rightX, r);
                    e.distance = DistancePointToEdge(x, y, e);
                    edges.Enqueue(e);
                }
                #endregion
                
                for (int c = leftCol; c <= rightCol; c++)
                {
                    #region Set Top and Bottom Boundary Edges
                    if (firstIteration)
                    {
                        
                        Cell topCell = Cave.grid[c, -topRow];
                        if (topCell == Cell.Empty || topCell == Cell.SlantNE || topCell == Cell.SlantNW)
                        {
                            LightEdge e = new LightEdge(c, topY, c + 1, topY);
                            e.distance = DistancePointToEdge(x, y, e);
                            edges.Enqueue(e);
                        }

                        Cell botCell = Cave.grid[c, -botRow];
                        if (botCell == Cell.Empty || botCell == Cell.SlantSE || botCell == Cell.SlantSW)
                        {
                            LightEdge e = new LightEdge(c + 1, botRow, c, botRow);
                            e.distance = DistancePointToEdge(x, y, e);
                            edges.Enqueue(e);
                        }

                    }
                    #endregion
                    
                    LightEdge ee = GetCellEdgeFacingPoint(c, r, x, y);
                    if (ee != null)
                    {
                        ee.distance = DistancePointToEdge(x, y, ee);
                        edges.Enqueue(ee);
                    }
                }
                firstIteration = false;
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
                        if (e.x2 == b.x1 && e.y2 == b.y1)
                        {
                            e.next = b;
                            b.prev = e;
                        }
                    }
                }
            }

            List<LightEdge> pedges = new List<LightEdge>();

            foreach (LightEdge e in edges.getData())
            {
                // set projections
                if (e.prev == null)
                {
                    Vector2 dir = new Vector2(e.x1 - x, e.y1 - y);
                    Vector2 line = dir.normalized * cam.orthographicSize * 10f;
                    LightEdge proj = new LightEdge(e.x1 + line.x, e.y1 + line.y, e.x1, e.y1);
                    proj.next = e;
                    proj.prev = null;
                    e.prev = proj;

                    // intersection logic
                    float pmag = (new Vector2(proj.x2 - proj.x1, proj.y2 - proj.x1)).magnitude;
                    foreach (LightEdge le in edges.getData())
                    {
                        float t = LightEdgesIntersect(le, proj);
                        Vector2 v = new Vector2(le.x2 - le.x1, le.y2 - le.y1);
                        v = v.normalized * v.magnitude * t;
                        float xi = le.x1 + v.x;
                        float yi = le.y1 + v.y;
                        float mag = Mathf.Sqrt(Mathf.Pow(proj.x2 - xi, 2) + Mathf.Pow(proj.y2 - yi, 2));
                        if (0 < t && t <= 1 && !le.Equals(e) && mag < pmag)
                        {
                            proj.prev = le;
                            le.next = proj;
                            proj.x1 = xi;
                            proj.y1 = yi;
                            le.x2 = xi;
                            le.y2 = yi;
                            pmag = mag;
                        }
                    }

                    proj.distance = DistancePointToEdge(x, y, proj);
                    pedges.Add(proj);
                }
                if (e.next == null)
                {
                    Vector2 dir = new Vector2(e.x2 - x, e.y2 - y);
                    Vector2 line = dir.normalized * cam.orthographicSize * 10f;
                    LightEdge proj = new LightEdge(e.x2, e.y2, e.x2 + line.x, e.y2 + line.y);
                    proj.prev = e;
                    proj.next = null;
                    e.next = proj;

                    // intersection logic
                    float pmag = (new Vector2(proj.x2 - proj.x1, proj.y2 - proj.x1)).magnitude;
                    foreach (LightEdge le in edges.getData())
                    {
                        float t = LightEdgesIntersect(proj, le);
                        Vector2 v = new Vector2(proj.x2 - proj.x1, proj.y2 - proj.y1);
                        v = v.normalized * v.magnitude * t;
                        float xi = proj.x1 + v.x;
                        float yi = proj.y1 + v.y;
                        float mag = Mathf.Sqrt(Mathf.Pow(proj.x1 - xi, 2) + Mathf.Pow(proj.y1 - yi, 2));
                        if (0 < t && t <= 1 && !le.Equals(e) && mag < pmag)
                        {
                            proj.next = le;
                            le.prev = proj;
                            proj.x2 = xi;
                            proj.y2 = yi;
                            le.x1 = xi;
                            le.y1 = yi;
                            pmag = mag;
                        }
                    }

                    proj.distance = DistancePointToEdge(x, y, proj);
                    pedges.Add(proj);
                }
            }

            // add projections to priority queue
            foreach (LightEdge e in pedges)
            {
                edges.Enqueue(e);
            }

            
            // debug next and previous edge links
            foreach (LightEdge e in edges.getData())
            {
                //DrawLightEdge(e, Color.red);
                if (e.next != null)
                {
                    // NEXT
                    DebugDrawSquare(e.x2, e.y2, 0.1f, Color.cyan);
                }
                else
                {
                    DebugDrawSquare(e.x2, e.y2, 0.2f, Color.magenta);
                    DebugDrawSquare(e.x2, e.y2, 0.25f, Color.magenta);
                }

                if (e.prev != null)
                {
                    // PREV
                    DebugDrawSquare(e.x1, e.y1, 0.05f, Color.green);
                }
                else
                {
                    DebugDrawSquare(e.x1, e.y1, 0.2f, Color.magenta);
                    DebugDrawSquare(e.x1, e.y1, 0.25f, Color.magenta);
                }
            }

            Mesh mesh = new Mesh();
            MeshFilter filter = GetComponent<MeshFilter>();

            int i = 0;
            LightEdge light = edges.Peek();
            List<Vector3> vertices = new List<Vector3>();
            vertices.Add(new Vector3(x, y, 0));
            do
            {
                vertices.Add(new Vector3(light.x1, light.y1, 0));
                //DrawLightEdge(light, Color.green);
                light = light.next;
                i++;
            } while (light != null && !light.Equals(edges.Peek()) && i < edges.getData().Count);

            List<Int32> indices = new List<Int32>();
            for (int v = 1; v < vertices.Count; v++)
            {
                indices.Add(0);
                indices.Add(v);
                int vv = v + 1;
                if (vv >= vertices.Count)
                {
                    vv = 1;
                }
                indices.Add(vv);
            }

            mesh.Clear();
            mesh.SetVertices(vertices);
            mesh.SetTriangles(indices, 0);

            lightTexture.Apply();
            filter.mesh = mesh;
        }

        private void DrawLightEdge(LightEdge e, Color col)
        {
            // debug light edges
            Vector3 p0 = cam.WorldToScreenPoint(new Vector3(e.x1, e.y1, 0));
            Vector3 p1 = cam.WorldToScreenPoint(new Vector3(e.x2, e.y2, 0));
            DrawLine(lightTexture, (int)p0.x, (int)p0.y, (int)p1.x, (int)p1.y, col);
            Debug.DrawLine(new Vector3(e.x1, e.y1, 0), new Vector3(e.x2, e.y2, 0), col);
            if (e.prev != null)
            {
                //DrawLine(lightTexture, (int)p0.x - 5, (int)p0.y - 5, (int)p0.x + 5, (int)p0.y + 5, Color.magenta);
            }
            if (e.next != null)
            {
                //DrawLine(lightTexture, (int)p1.x + 5, (int)p1.y - 5, (int)p1.x - 5, (int)p1.y + 5, new Color(1f, 1f, 1, 1));
                //DrawLine(lightTexture, (int)p1.x - 5, (int)p1.y - 5, (int)p1.x + 5, (int)p1.y + 5, Color.white);
            }
        }

        private void DebugDrawSquare(float x, float y, float r, Color color)
        {
            Debug.DrawLine(new Vector3(x - r, y - r, 0), new Vector3(x + r, y - r, 0), color);
            Debug.DrawLine(new Vector3(x - r, y + r, 0), new Vector3(x + r, y + r, 0), color);
            Debug.DrawLine(new Vector3(x - r, y - r, 0), new Vector3(x - r, y + r, 0), color);
            Debug.DrawLine(new Vector3(x + r, y - r, 0), new Vector3(x + r, y + r, 0), color);
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
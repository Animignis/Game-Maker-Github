using UnityEngine;
using System.Collections;
using System.Collections.Generic;

using Assets.Scripts;

public class Cave : MonoBehaviour {

    public GameObject tilePrefab;

    private class GridPoint
    {
        public int row;
        public int columm;

        public GridPoint(int row, int column)
        {
            this.row = row;
            this.columm = column;
        }
    }

    public static Cell[,] grid;
    public const float CELL_SIZE = 1.0f;
    public const int CAVE_WIDTH = 128;
    public const int CAVE_HEIGHT = 128;

    // cave generation variables
    private float fillRatio = 0.45f;
    private const int NUM_STEPS = 25;
    private const int DEATH_LIM = 3;
    private const int BIRTH_LIM = 4;
    private const int REVIVE_NUM = 3;

    // de-cheesing variables
    private Cell[,] pgrid;
    private ArrayList fill = new ArrayList();
    private int cheeseThresh;

    private Texture2D textureTest;
    private Sprite slantNE;
    private Sprite slantNW;
    private Sprite slantSW;
    private Sprite slantSE;

	// Use this for initialization
	void Start () {
        //tilePrefab = Resources.Load("Prefabs/Tile") as GameObject;

        slantNE = (Sprite)Resources.Load("Backgrounds/SlantNE", typeof(Sprite));
        slantNW = (Sprite)Resources.Load("Backgrounds/SlantNW", typeof(Sprite));
        slantSW = (Sprite)Resources.Load("Backgrounds/SlantSW", typeof(Sprite));
        slantSE = (Sprite)Resources.Load("Backgrounds/SlantSE", typeof(Sprite));

        fillRatio = Random.Range(0.44f, 0.48f);
        cheeseThresh = (int) Mathf.Floor(CAVE_WIDTH * CAVE_HEIGHT / 6.0f);
        grid = new Cell[CAVE_WIDTH, CAVE_HEIGHT];

        // randomize grid
        for (int c = 0; c < CAVE_WIDTH; c++)
        {
            for (int r = 0; r < CAVE_HEIGHT; r++)
            {
                if (Random.value < fillRatio)
                {
                    grid[c, r] = Cell.Filled;
                }
                else
                {
                    grid[c, r] = Cell.Empty;
                }
            }
        }

        // generate cave level
        for (int i = 0; i < NUM_STEPS; i++) 
        {
            GenerateCave();
        }
        
        //fill borders
        for (var r = 0; r < CAVE_HEIGHT; r++)
        {
            grid[0, r] = (int)Cell.Filled;
            grid[CAVE_WIDTH - 1, r] = (int)Cell.Filled;
        }
        for (var c = 0; c < CAVE_WIDTH; c++)
        {
            grid[c, 0] = (int)Cell.Filled;
            grid[c, CAVE_HEIGHT - 1] = (int)Cell.Filled;
        }

        
        // decheese
        pgrid = new Cell[CAVE_WIDTH, CAVE_HEIGHT];
        pgrid = (Cell[,]) grid.Clone();
        DeCheeseCave();

        // Find/Set Slants/Edges
        FindSlants();
        FindEdges();

        /*
        for (int r = 0; r < CAVE_HEIGHT; r++)
        {
            for (int c = 0; c < CAVE_WIDTH; c++)
            {
                if (grid[c, r] == Cell.Filled)
                {
                    grid[c, r] = Cell.Empty;
                }
            }
        }
        */

        Debug.Log("Cave Done");
        
        setTextureTest();
        
	}

    void setTextureTest()
    {
        textureTest = new Texture2D(CAVE_WIDTH, CAVE_HEIGHT);
        for (int r = 0; r < CAVE_HEIGHT; r++)
        {
            for (int c = 0; c < CAVE_WIDTH; c++)
            {
                Sprite spr = (Sprite) Resources.Load("Backgrounds/Filled", typeof(Sprite));
                if (grid[c, r] == Cell.Empty)
                {
                    textureTest.SetPixel(c, CAVE_HEIGHT - r, new Color(1, 1, 1, 0.5f));
                }
                else if (grid[c, r] == Cell.Filled)
                {
                    textureTest.SetPixel(c, CAVE_HEIGHT - r, new Color(0, 0, 1, 0.5f));
                }
                else
                {
                    switch (grid[c, r])
                    {
                        default:
                            textureTest.SetPixel(c, CAVE_HEIGHT - r, new Color(0, 1, 0, 1));
                            break;
                    }
                    
                }

                if (grid[c, r] != Cell.Empty)
                {
                    GameObject go = (GameObject)Instantiate(tilePrefab, new Vector3(c * CELL_SIZE, -r * CELL_SIZE, 10), Quaternion.identity);

                    List<Vector2> path = new List<Vector2>();
                    path.AddRange(go.GetComponent<PolygonCollider2D>().GetPath(0));
                    Color col = Color.white;
                    switch (grid[c, r])
                    {
                        case Cell.SlantNE:
                            spr = slantNE;
                            path.RemoveAt(3);
                            break;
                        case Cell.SlantNW:
                            spr = slantNW;
                            path.RemoveAt(0);
                            break;
                        case Cell.SlantSE:
                            spr = slantSE;
                            path.RemoveAt(2);
                            break;
                        case Cell.SlantSW:
                            spr = slantSW;
                            path.RemoveAt(1);
                            break;
                    }

                    Vector2[] arr = new Vector2[path.Count];
                    for (int i = 0; i < path.Count; i++)
                    {
                        arr[i] = new Vector2(path[i].x, path[i].y);
                    }
                    go.GetComponent<PolygonCollider2D>().SetPath(0, arr);

                    go.GetComponent<SpriteRenderer>().sprite = spr;
                    go.GetComponent<SpriteRenderer>().color = col;

                    go.transform.localScale = new Vector3(CELL_SIZE, CELL_SIZE, CELL_SIZE);
                }
            }
        }
        textureTest.Apply();
    }

    // Update is called once per frame
    void Update()
    {

    }

    void OnGUI()
    {

        GameObject player = GameObject.Find("Player");
        textureTest.SetPixel(Mathf.FloorToInt(player.transform.position.x), Mathf.FloorToInt(player.transform.position.y), Color.cyan);
        textureTest.Apply();
        GUI.skin.box.normal.background = textureTest;
        GUI.Box(new Rect(32, 32, CAVE_WIDTH * 2, CAVE_HEIGHT * 2), GUIContent.none);
    }

    public Cell Get(int c, int r)
    {
        return grid[c, r];
    }

    #region Generator
    private void GenerateCave()
    {
        Cell[,] newGrid = new Cell[CAVE_WIDTH, CAVE_HEIGHT];
        for (int r = 0; r < CAVE_HEIGHT; r++)
        {
            for (int c = 0; c < CAVE_WIDTH; c++)
            {
                float nbs = CountAliveNeighbors(r, c);
                if (grid[c, r] == 0)
                {
                    if (nbs < DEATH_LIM)
                    {
                        newGrid[c, r] = Cell.Empty;
                    }
                    else
                    {
                        newGrid[c, r] = Cell.Filled;
                    }
                }
                else
                {
                    if (nbs > BIRTH_LIM)
                    {
                        newGrid[c, r] = Cell.Filled;
                    }
                    else
                    {
                        newGrid[c, r] = Cell.Empty;
                    }
                }
            }
        }
        for (int r = 0; r < CAVE_HEIGHT; r++)
        {
            for (int c = 0; c < CAVE_WIDTH; c++)
            {
                grid[c, r] = newGrid[c, r];
            }
        }
        //grid = newGrid;
        //grid = (Cell[,]) newGrid.Clone();
    }

    private void DeCheeseCave()
    {
        for (int r = 1; r < CAVE_HEIGHT - 1; r++)
        {
            for (int c = 1; c < CAVE_WIDTH - 1; c++)
            {
                if (pgrid[c, r] == Cell.Empty)
                {
                    if (GetCavernSize(r, c) > cheeseThresh)
                    {
                        for (var i = 0; i < fill.Count; i++)
                        {
                            GridPoint p = (GridPoint)fill[i];
                            grid[p.columm, p.row] = Cell.Empty;
                        }
                    }
                }
                fill.Clear();
            }
        }
    }

    private int GetCavernSize(int r, int c)
    {
        int i = 0;
        Queue q = new Queue();
        q.Enqueue(new GridPoint(r, c));
        while (q.Count > 0)
        {
            GridPoint p = (GridPoint)q.Dequeue();
            int row = p.row;
            int col = p.columm;
            if (pgrid[col, row] == Cell.Empty)
            {
                i++;
                fill.Add(new GridPoint(row, col));
                grid[col, row] = (int)Cell.Filled;
                pgrid[col, row] = 0;
                q.Enqueue(new GridPoint(row, col + 1));
                q.Enqueue(new GridPoint(row - 1, col));
                q.Enqueue(new GridPoint(row, col - 1));
                q.Enqueue(new GridPoint(row + 1, col));
            }
        }
        return i;
    }

    private void FindSlants()
    {
        for (int r = 0; r < CAVE_HEIGHT; r++)
        {
            for (int c = 0; c < CAVE_WIDTH; c++)
            {
                if (grid[c, r] == Cell.Empty)
                {
                    SetSlant(r, c);
                }
            }
        }
    }

    private void FindEdges()
    {
        for (int r = 0; r < CAVE_HEIGHT; r++)
        {
            for (int c = 0; c < CAVE_WIDTH; c++)
            {
                if (grid[c, r] == Cell.Filled)
                {
                    if (!SetSlantFilled(r, c))
                    {
                        SetEdge(r, c);
                    }
                }
                if (grid[c, r] == Cell.Empty)
                {
                    // TODO: add to empty list
                }
            }
        }
    }

    private bool SetSlant(int r, int c)
    {
        if (CountAliveNeighbors(r, c) >= 2)
        {
            if (c > 0 && r > 0 && grid[c - 1, r] == 0 && grid[c, r - 1] == 0
                    && grid[c, r + 1] != 0 && grid[c + 1, r] != 0)
            {
                grid[c, r] = Cell.SlantSE;
                return true;
            }
            else if (c > 0 && r < CAVE_HEIGHT - 1 && grid[c - 1, r] == 0 && grid[c, r + 1] == 0
                    && grid[c, r - 1] != 0 && grid[c + 1, r] != 0)
            {
                grid[c, r] = Cell.SlantNE;
                return true;
            }
            else if (c < CAVE_WIDTH - 1 && r < CAVE_HEIGHT - 1 && grid[c + 1, r] == 0 && grid[c, r + 1] == 0
                    && grid[c, r - 1] != 0 && grid[c - 1, r] != 0)
            {
                grid[c, r] = Cell.SlantNW;
                return true;
            }
            else if (c < CAVE_WIDTH - 1 && r > 0 && grid[c + 1, r] == 0 && grid[c, r - 1] == 0
                    && grid[c, r + 1] != 0 && grid[c - 1, r] != 0)
            {
                grid[c, r] = Cell.SlantSW;
                return true;
            }
        }
        return false;
    }

    private bool CellIsFilled(int c, int r)
    {
        int cell = (int)grid[c, r];
        return !((cell >= 1 && cell <= 4) || cell == -1);
    }

    private bool SetSlantFilled(int r, int c)
    {
        if (CountAliveNeighborsInt(r, c) >= 2)
        {
            if (c > 0 && r > 0 && c < CAVE_WIDTH - 1 && r < CAVE_HEIGHT - 1
                    && CellIsFilled(c - 1, r)
                    && CellIsFilled(c, r - 1)
                    && grid[c, r + 1] == Cell.Empty
                    && grid[c + 1, r] == Cell.Empty)
            {
                grid[c, r] = Cell.SlantSE;
                return true;
            }
            else if (c > 0 && r > 0 && c < CAVE_WIDTH - 1 && r < CAVE_HEIGHT - 1
                    && CellIsFilled(c - 1, r)
                    && CellIsFilled(c, r + 1)
                    && grid[c, r - 1] == Cell.Empty
                    && grid[c + 1, r] == Cell.Empty)
            {
                grid[c, r] = Cell.SlantNE;
                return true;
            }
            else if (c > 0 && r > 0 && c < CAVE_WIDTH - 1 && r < CAVE_HEIGHT - 1
                    && CellIsFilled(c + 1, r)
                    && CellIsFilled(c, r + 1)
                    && grid[c, r - 1] == Cell.Empty
                    && grid[c - 1, r] == Cell.Empty)
            {
                grid[c, r] = Cell.SlantNW;
                return true;
            }
            else if (c > 0 && r > 0 && c < CAVE_WIDTH - 1 && r < CAVE_HEIGHT - 1
                    && CellIsFilled(c + 1, r)
                    && CellIsFilled(c, r - 1)
                    && grid[c, r + 1] == Cell.Empty
                    && grid[c - 1, r] == Cell.Empty)
            {
                grid[c, r] = Cell.SlantSW;
                return true;
            }
        }
        return false;
    }

    private bool SetEdge(int r, int c)
    {
        if (c < CAVE_WIDTH - 1 && grid[c + 1, r] == Cell.Empty)
        {
            grid[c, r] = Cell.EdgeE;
            return true;
        }
        if (r > 0 && grid[c, r - 1] == Cell.Empty)
        {
            grid[c, r] = Cell.EdgeN;
            return true;
        }
        if (c > 0 && grid[c - 1, r] == Cell.Empty)
        {
            grid[c, r] = Cell.EdgeW;
            return true;
        }
        if (r < CAVE_HEIGHT - 1 && grid[c, r + 1] == Cell.Empty)
        {
            grid[c, r] = Cell.EdgeS;
            return true;
        }
        return false;
    }

    private float CountAliveNeighbors(int r, int c)
    {
        float count = 0;
        for (int i = -1; i <= 1; i++)
        {
            for (int k = -1; k <= 1; k++)
            {
                int nr = r + i;
                int nc = c + k;
                float val = 1.0f;
                if (Mathf.Abs(i) == 1 && Mathf.Abs(k) == 1)
                {
                    val = 0.7f;
                }
                if (!(i == 0 && k == 0))
                {
                    if (nr < 0 || nc < 0 || nr >= CAVE_HEIGHT || nc >= CAVE_WIDTH)
                    {
                        count += val;
                    }
                    else if (grid[nc, nr] == Cell.Filled)
                    {
                        count += val;
                    }
                }
            }
        }
        return count;
    }

    private int CountAliveNeighborsInt(int r, int c)
    {
        int count = 0;
        for (int i = -1; i < 2; i++)
        {
            for (int j = -1; j < 2; j++)
            {
                int nr = r + i;
                int nc = c + j;
                if (!(i == 0 && j == 0))
                {
                    if (nr < 0 || nc < 0 || nr >= CAVE_HEIGHT || nc >= CAVE_WIDTH)
                    {
                        count++;
                    }
                    else if (grid[nc, nr] == 0)
                    {
                        count++;
                    }
                }
            }
        }

        return count;
    }
    #endregion

}

public enum Cell
{
    Empty = -1,
    Filled = 0,
    SlantNE = 1,
    SlantNW = 2,
    SlantSW = 3,
    SlantSE = 4,
    EdgeE = 5,
    EdgeN = 6,
    EdgeW = 7,
    EdgeS = 8
}
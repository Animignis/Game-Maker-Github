using UnityEngine;
using System.Collections;
using Assets.Scripts;

public class Player : MonoBehaviour {

    private const float DIAG = 0.70710678118f; // sqrt(2)/2

    private GameObject cam;

    private Stats stats;

	// Use this for initialization
	void Start ()
    {
        cam = GameObject.Find("MainCamera");
        stats = new Stats(
            1000,   // max health
            0.001f, // health regen
            12,     // damage
            0.3f,   // accuracy
            0.02f,  // crit chance
            1.0f,   // attack speed
            5.0f,   // move speed
            100);   // weight
	}
	
	// Update is called once per frame
	void Update ()
    {
        Move();
        // TODO: Handle wall collisions

        // TODO: Attack/ability logic
	}

    private void Move()
    {
        // normal movement
        Vector3 move = CaptureMovementInput();
        transform.position += move * stats.MoveSpeed * Time.deltaTime;

        // adjust camera offset
        Vector3 mouseInWorld = cam.GetComponent<Camera>().ScreenToWorldPoint(Input.mousePosition);
        Vector3 cameraOffset = transform.position + (mouseInWorld - transform.position) * 0.3f;
        cameraOffset.z = -10.0f;
        cam.transform.position = cameraOffset;

        // mouse aim
        Vector2 positionOnScreen = cam.GetComponent<Camera>().WorldToViewportPoint(transform.position);
        Vector2 mouseOnScreen = (Vector2)cam.GetComponent<Camera>().ScreenToViewportPoint(Input.mousePosition);
        float angle = AngleBetweenTwoPoints(positionOnScreen, mouseOnScreen) + 180;
        transform.rotation = Quaternion.Euler(new Vector3(0, 0, angle));
    }

    private Vector3 CaptureMovementInput()
    {
        float dx = 0;
        float dy = 0;

        if (Input.GetKey(KeyCode.W))
        {
            dy += 1;
        }
        if (Input.GetKey(KeyCode.A))
        {
            dx -= 1;
        }
        if (Input.GetKey(KeyCode.S))
        {
            dy -= 1;
        }
        if (Input.GetKey(KeyCode.D))
        {
            dx += 1;
        }

        if (dx != 0 && dy != 0)
        {
            dx *= DIAG;
            dy *= DIAG;
        }

        return new Vector3(dx, dy, 0);
    }

    void OnGUI()
    {
    }

    private float AngleBetweenTwoPoints(Vector3 a, Vector3 b)
    {
        return Mathf.Atan2(a.y - b.y, a.x - b.x) * Mathf.Rad2Deg;
    }
}

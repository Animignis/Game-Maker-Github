using UnityEngine;
using System.Collections;
using Assets.Scripts;

public class Player : MonoBehaviour {

    private GameObject cam;

    private Stats stats;

    private const float SHAKE_AMOUNT = 0.1f;
    private bool shake = false;
    private float shakeTimeStop = 0;

    private float accel = 100;
    private float friction = 0.6f;
    private Rigidbody2D rb;


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

        rb = this.GetComponent<Rigidbody2D>();
	}
	
	// Update is called once per frame
	void Update ()
    {
        
	}

    void FixedUpdate()
    {
        if (Input.GetKey(KeyCode.Space))
        {
            // shakeTimeStop = Time.realtimeSinceStartup + 1.0f;
        }

        Move();

        // TODO: Handle wall collisions

        // TODO: Attack/ability logic
    }

    private void Move()
    {
        // normal movement
        Vector3 move = CaptureMovementInput();
        float dx = move.x;
        float dy = move.y;
		float ax = dx * accel;
		float ay = dy * accel;
		this.rb.AddForce(new Vector2 (ax, ay));
		this.rb.velocity = Mathf.Clamp(this.rb.velocity.magnitude, 0, stats.MoveSpeed) * this.rb.velocity.normalized;
		if (dx == 0 && dy == 0)
		{
			this.rb.velocity *= friction;
			if (this.rb.velocity.magnitude < 0.001f)
			{
				this.rb.velocity = new Vector2(0, 0);
			}
		}

        //transform.position += move * stats.MoveSpeed * Time.deltaTime;

        // adjust camera offset
        Vector3 mouseInWorld = cam.GetComponent<Camera>().ScreenToWorldPoint(Input.mousePosition);
        Vector3 cameraOffset = transform.position + (mouseInWorld - transform.position) * 0.3f;
        cameraOffset.z = -10.0f;
        if (Time.realtimeSinceStartup < shakeTimeStop)
        {
            cameraOffset.x += Random.Range(-SHAKE_AMOUNT, SHAKE_AMOUNT);
            cameraOffset.y += Random.Range(-SHAKE_AMOUNT, SHAKE_AMOUNT);
        }
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

        return (new Vector3(dx, dy, 0)).normalized;
    }

    void OnGUI()
    {
    }

    private float AngleBetweenTwoPoints(Vector3 a, Vector3 b)
    {
        return Mathf.Atan2(a.y - b.y, a.x - b.x) * Mathf.Rad2Deg;
    }
}

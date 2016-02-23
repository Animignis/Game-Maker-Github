using UnityEngine;
using System.Collections;

public class Tile : MonoBehaviour {
    
    public void Init(Sprite spr)
    {
        this.GetComponent<SpriteRenderer>().sprite = spr;
    }

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}

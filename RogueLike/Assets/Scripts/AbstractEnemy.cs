using UnityEngine;
using System.Collections;

public abstract class AbstractEnemyBehavior : MonoBehaviour {

    protected enum AiState
    {
        Wander,
        Chase,
        Attack,
        Hurt
    }

    protected AiState state;

    private float sightRange;
    private float sightAngle;

    private float wanderChance;
    private float hurtTime;


	// Use this for initialization
	void Start () 
    {
	
	}
	
	// Update is called once per frame
	void Update () 
    {
        switch (state)
        {
            case AiState.Wander:
                Wander();
                break;

            case AiState.Chase:
                Chase();
                break;

            case AiState.Attack:
                Attack();
                break;

            case AiState.Hurt:
                Hurt();
                break;
        }
	}

    protected abstract void Wander();

    protected abstract void Chase();

    protected abstract void Attack();

    protected abstract void Hurt();
}

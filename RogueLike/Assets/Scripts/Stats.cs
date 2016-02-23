using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Assets.Scripts
{
    class Stats
    {
        /*
        public enum Status
        {
            Vulnerable,
            Intangible,
            Invincible
        }
        private Status status;
        */

        private float maxHealth;
        private float health;
        private float healthRegen;

        private float damage;
        private float accuracy;
        private float critChance;

        private float attackSpeed;
        private float moveSpeed;
        private float weight;

        public float MaxHealth
        {
            get { return maxHealth; }
            set { maxHealth = value; }
        }
        public float Health
        {
            get { return health; }
            set { health = value; }
        }
        public float HealthRegen
        {
            get { return healthRegen; }
            set { healthRegen = value; }
        }

        public float Damage
        {
            get { return damage; }
            set { damage = value; }
        }
        public float Accuracy
        {
            get { return accuracy; }
            set { accuracy = value; }
        }
        public float CritChance
        {
            get { return critChance; }
            set { critChance = value; }
        }

        public float AttackSpeed
        {
            get { return attackSpeed; }
            set { attackSpeed = value; }
        }
        public float MoveSpeed
        {
            get { return moveSpeed; }
            set { moveSpeed = value; }
        }
        public float Weight
        {
            get { return weight; }
            set { weight = value; }
        }

        public Stats(float maxHealth, float healthRegen, float damage, float accuracy, float critChance, float attackSpeed, float moveSpeed, float weight)
        {
            this.maxHealth = maxHealth;
            this.health = this.maxHealth;
            this.healthRegen = healthRegen;
            this.damage = damage;
            this.accuracy = accuracy;
            this.critChance = critChance;
            this.attackSpeed = attackSpeed;
            this.moveSpeed = moveSpeed;
            this.weight = weight;
        }

        public Stats()
        {
            this.maxHealth = 0;
            this.health = 0;
            this.healthRegen = 0;
            this.damage = 0;
            this.accuracy = 0;
            this.critChance = 0;
            this.attackSpeed = 0;
            this.moveSpeed = 0;
            this.weight = 0;
        }
    }
}

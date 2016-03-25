using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Assets.Scripts
{
    public class LightEdge : IComparable<LightEdge>
    {
        public LightEdge prev;
        public LightEdge next;
        public float x1;
        public float y1;
        public float x2;
        public float y2;
        public float distance;

        public LightEdge(float x1, float y1, float x2, float y2)
        {
            this.prev = null;
            this.next = null;

            this.x1 = x1;
            this.y1 = y1;
            this.x2 = x2;
            this.y2 = y2;
        }

        public LightEdge(float x1, float y1, float x2, float y2, LightEdge next, LightEdge prev)
        {
            this.prev = prev;
            this.next = next;

            this.x1 = x1;
            this.y1 = y1;
            this.x2 = x2;
            this.y2 = y2;
        }

        public int CompareTo(LightEdge other)
        {
            if (this.distance < other.distance) return -1;
            else if (this.distance > other.distance) return 1;
            else { return 0; }
        }

        public override bool Equals(object obj)
        {
            LightEdge other = (LightEdge) obj;
            return this.x1 == other.x1 && this.x2 == other.x2 && this.y1 == other.y1 && this.y2 == other.y2;
        }
    }
}

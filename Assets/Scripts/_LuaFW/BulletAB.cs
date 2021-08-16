using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BulletAB : MonoBehaviour
{
    public Transform Target;
    public void Gettarget(Transform target)
    {
        if (target != null)
            Target = target;
    }

    public Transform GetTarget()
    {
        return Target;
    }

    public void DestroyGameObject()
    {
        //Destroy(this.gameObject);
        this.gameObject.SetActive(false);
    }
}

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class A_Timer : MonoBehaviour
{
    public static A_Timer _Instance;
    public static A_Timer GetInstance()
    {
        if (_Instance == null)
        {
            _Instance = new A_Timer();
        }
        return _Instance;
    }




}

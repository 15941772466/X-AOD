using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class UnitySingleTon<T> : MonoBehaviour
    where  T : Component
{
    private static T _instance;
    public static T Instance
    {
        get
        {
            if(_instance == null)
            {
                _instance = FindObjectsOfType(typeof(T)) as T;   //as强转
                if(_instance == null)
                {
                    GameObject obj = new GameObject();
                    obj.hideFlags = HideFlags.HideAndDontSave; //隐藏实例化的new game object
                    _instance = obj.AddComponent<T>();
                }
            }
            return _instance;
        }
    }
}

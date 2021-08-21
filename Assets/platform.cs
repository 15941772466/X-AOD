using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using ABFW;

public class platform : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        string s = PathTools.GetABOutPath();
        Debug.Log(Application.platform);
        Debug.Log(s);
        Debug.Log(Application.dataPath + "/" + "AB_Resources");
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}

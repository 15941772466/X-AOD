using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.IO;
using Google.Protobuf;
using XProgect;

public class Login : MonoBehaviour
{
    public static bool LogIn(string id ,string password)
    {
        if (File.Exists(Application.dataPath + "/" + id))
        {
            byte[] read = File.ReadAllBytes(Application.dataPath + "/" + id);
            Gamedata message = new Gamedata();
            message.MergeFrom(read);
            if (password==message.Password)
            {
                return true;
            }
            return false;
        }
        else
        {
            return false;
        }
    }
}

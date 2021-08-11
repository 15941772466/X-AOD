﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.IO;
using Google.Protobuf;
using XProgect;

namespace LoginRes
{
    public class Login : MonoBehaviour
    {
        public static bool LogIn(string id, string password)
        {
            print(id + "   " + password);
            if (File.Exists(Application.dataPath + "/ID/" + id))
            {
                byte[] read = File.ReadAllBytes(Application.dataPath + "/ID/" + id);
                Gamedata message = new Gamedata();
                message.MergeFrom(read);
                if (password == message.Password)
                {
                    print("登录成功");
                    return true;
                }
                print("密码错误");
                return false;
            }
            else
            {
                print("用户名不存在");
                return false;
            }
        }
    }
}

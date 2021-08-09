using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using XProgect;
using Google.Protobuf;
using System.IO;

public class Savegame : MonoBehaviour
{
   public static bool SaveGame(string id,string name,string password,int cin,List<string> tower)
   {
        Gamedata gamedata = new Gamedata();
        gamedata.ID = id;
        gamedata.Name = name;
        gamedata.Password = password;
        gamedata.Coin = cin;
        foreach (var item in tower)
        {
            gamedata.Tower.Add(item);
        }
        try
        {
            byte[] tem = gamedata.ToByteArray();
            FileStream stream=File.Create(Application.dataPath+"/"+name);
            stream.Write(tem, 0, tem.Length);
        }
        catch
        {
            return false;
        }
        return true;
   }
}

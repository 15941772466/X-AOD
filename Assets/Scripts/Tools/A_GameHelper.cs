﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace GameTools {
    public class A_GameHelper : MonoBehaviour
    {
        public Slider slider;
        //设置单例
        public static A_GameHelper _Instance;
        public static A_GameHelper GetInstance()
        {
            if (_Instance == null)
            {
                _Instance = new A_GameHelper();
            }
            return _Instance;
        }


        //遍历物体所有子物体的名字
        public List<string> GetChildName(GameObject obj, List<string> namelist)
        {
            foreach (Transform child in obj.transform)
            {
                namelist.Add(child.gameObject.name);
            }
            return namelist;
        }

        //----------------------------------------炮塔建造管理--------------------------------

        //检测与UI碰撞
        public bool IsOverGameObject()
        {
            bool isOver = EventSystem.current.IsPointerOverGameObject();
            return isOver;
        }

        //射线检测
        public bool isCollider()
        {
            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            bool iscollider = Physics.Raycast(ray, 1000,LayerMask.GetMask("Ground"));
            return iscollider;
        }
        //射线碰撞检测
        public RaycastHit HitInfro()
        {
            RaycastHit hit;
            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            Physics.Raycast(ray, out hit, 1000, LayerMask.GetMask("Ground"));
            return hit;
        }



        //炮塔位置上调
        public Vector3 UpPosition(ref Vector3 position)
        {
            position.y = 0.2f;
            return position;
        }

        //炮塔指向
        public void LookAt(Transform Head, Vector3 target)
        {
            Head.LookAt(target);
        }
        //子弹保持y轴朝向
        public void KeepY(GameObject gameObject,Transform target)
        {
            target.position = new Vector3(target.position.x, gameObject.transform.position.y, target.position.z);
        }
        //子弹位移
        public  void Translate(GameObject bullet,float speed)
        {
            bullet.transform.Translate(Vector3.forward * speed * Time.deltaTime);
        }

        public float UpdateTimer(float timer)
        {
            timer += Time.deltaTime;
            return timer;
        }
        //判断子弹是否到达敌人
        public bool IsReach(GameObject obj,Transform target)
        {   Vector3 Distance = obj.transform.position - target.position;
            bool res=false;
            if (Distance.magnitude < 0.5)
                res = true;
            return res;
        }

        //---------------------------------------敌人管理---------------------------------

        //血条UI上移
        public void SliderUp(GameObject slider)
        {
            slider.transform.position += Vector3.up;
        }
    }
}

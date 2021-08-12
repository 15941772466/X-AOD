using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

namespace GameTools {
    public class A_GameHelper:MonoBehaviour
    {
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
        //敌人生成间隔协程
        private Coroutine coroutine1;
        //波次间隔协程
        private Coroutine coroutine2;

        //遍历物体所有子物体的名字
        public List<string> GetChildName(GameObject obj, List<string> namelist)
        {
            foreach (Transform child in obj.transform)
            {
                namelist.Add(child.gameObject.name);
            }
            return namelist;
        }

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
            bool iscollider = Physics.Raycast(ray, 1000);
            return iscollider;
        }
        //射线碰撞检测
        public RaycastHit HitInfro()
        {
            RaycastHit hit;
            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            Physics.Raycast(ray, out hit, 1000);
            return hit;
        }

        //同波敌人生成间隔
        IEnumerator SpawnEnemyRate(float count)
        {
            while (count >= 0)
            {
                yield return new WaitForSeconds(1);
                count--;
            }

        }
        public void StartSpawnEnemyRate(float count)
        {
            coroutine1=StartCoroutine(SpawnEnemyRate(count));
        }
        public void ClosetSpawnEnemyRate()
        {
            StopCoroutine(coroutine1);
        }
        //波次敌人生成间隔

    }
}

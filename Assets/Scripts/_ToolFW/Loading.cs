using UnityEngine;
using System.Collections;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

namespace TFW
{    
    public class Loading : MonoBehaviour
    {
        public GameObject objProcessBar;
        public Text percent;

        public void Load(string str)
        {
            StartCoroutine(StartLoading(str));
        }
        IEnumerator StartLoading(string str)
        {
            float i = 0;
            AsyncOperation acOp = SceneManager.LoadSceneAsync(str);
            acOp.allowSceneActivation = false;
            while (i <= 100)
            {
                i++;
                objProcessBar.GetComponent<Slider>().value = i / 100;
                yield return new WaitForEndOfFrame();
                percent.text = i.ToString() + "%";
            }
            acOp.allowSceneActivation = true;
            this.gameObject.SetActive(false);
        }
    }
}

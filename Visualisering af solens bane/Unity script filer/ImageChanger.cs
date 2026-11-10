using UnityEngine;
using UnityEngine.UI;

public class ImageChanger : MonoBehaviour
{
    public Sprite[] sprites;
    private Image targetImage;
    private int currentIndex = 0;
    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        targetImage = GetComponent<Image>();
        targetImage.sprite = sprites[0];
    }

    public void IncrementStep()
    {
        if (currentIndex == sprites.Length - 1)
        {
            currentIndex = 0;
            targetImage.sprite = sprites[0];
        } else
        {
            currentIndex += 1;
            targetImage.sprite = sprites[currentIndex];
        }
    }
    public void DecrementStep()
    {
        if (currentIndex == 0)
        {
            currentIndex = sprites.Length - 1;
            targetImage.sprite = sprites[currentIndex];
        } else
        {
            currentIndex -= 1;
            targetImage.sprite = sprites[currentIndex];
        }
    }
}

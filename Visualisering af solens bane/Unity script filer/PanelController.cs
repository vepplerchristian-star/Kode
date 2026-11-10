using Unity.Mathematics;
using UnityEngine;

public class PanelController : MonoBehaviour
{
    public GameObject sunControllerObject;
    private SunController sunController;
    public ImageChanger motor1;
    public ImageChanger motor2;
    private float stepSize = 1.8f;
    private float currentX;
    private float currentY;
    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        sunController = sunControllerObject.GetComponent<SunController>();
    }

    // Update is called once per frame
    void Update()
    {
        Vector3 sunAngles = sunControllerObject.transform.eulerAngles;

        // Håndter X-aksen (Motor 1)
        float deltaX = Mathf.DeltaAngle(currentX, sunAngles.x);
        if (Mathf.Abs(deltaX) >= stepSize)
        {
            float stepsX = Mathf.Round(deltaX / stepSize);
            float nextX = currentX + (stepsX * stepSize);


            nextX = Mathf.Clamp(nextX, 34.1f, 145.9f); 


            if (Mathf.Abs(nextX - currentX) >= stepSize)
            {
                if (motor2.gameObject.activeInHierarchy)
                {
                    if (nextX - currentX > 0)
                    {
                        motor2.IncrementStep();
                    } else if (nextX - currentX < 0)
                    {
                        motor2.DecrementStep();
                    }
                }
                
                currentX = nextX;
            }
        }

        // Håndter Y-aksen (Motor 2)
        float deltaY = Mathf.DeltaAngle(currentY, sunAngles.y);
        if (Mathf.Abs(deltaY) >= stepSize)
        {
            float stepsY = Mathf.Round(deltaY / stepSize);
            currentY += stepsY * stepSize;
            if (motor1.gameObject.activeInHierarchy)
            {
                if (deltaY > 0)
                {
                    motor1.IncrementStep();
                } else if (deltaY < 0)
                {
                    motor1.DecrementStep();
                }
            }
            
        }

        transform.localRotation = Quaternion.Euler(currentX, currentY, 0f);
    }
}

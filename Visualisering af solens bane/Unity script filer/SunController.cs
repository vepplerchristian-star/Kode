using System;
using UnityEngine;

public class SunController : MonoBehaviour
{
    [Header("Time Settings")]
    public float currentTimeOfDay = 12f;
    public float dayLengthInSeconds = 120f;

    [Header("Seasonal Settings")]
    public float currentDayOfYear = 180f; 
    private int actualDay = 180;
    public float maxAxialTilt = 23.5f;

    [Header("Location Settings")]
    public float latitude = 40f;


    void Update()
    {
        UpdateTime();
        UpdateSunPosition();
    }

    private void UpdateTime()
    {
        currentTimeOfDay += (Time.deltaTime / dayLengthInSeconds) * 24f;
        currentDayOfYear = actualDay + currentTimeOfDay / 24;
        if (currentTimeOfDay >= 24f) {currentTimeOfDay -= 24f; actualDay += 1;}
        if (actualDay > 365) actualDay = 0;
    }

    private void UpdateSunPosition()
    {

        float seasonalProgress = (currentDayOfYear - 172f) / 365f;
        float currentTilt = Mathf.Sin(seasonalProgress * 2f * Mathf.PI) * maxAxialTilt;


        Quaternion latitudeRotation = Quaternion.Euler(90f - latitude, 0f, 0f);


        Quaternion seasonalTilt = Quaternion.Euler(currentTilt, 0f, 0f);


        float dailyAngle = ((currentTimeOfDay - 12f) / 24f) * 360f;
        Quaternion dailyRotation = Quaternion.Euler(0f, dailyAngle, 0f);


        transform.rotation = latitudeRotation * seasonalTilt * dailyRotation;
    }
}

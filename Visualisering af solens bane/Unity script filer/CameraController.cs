using UnityEngine;
using UnityEngine.InputSystem; 
public class CameraController : MonoBehaviour
{
    [SerializeField] private GameObject canvas;
    public float movSpeed = 10f;
    public float mouseSens = 0.1f;

    private float rotX = 0f;
    private float rotY = 0f;
    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        Cursor.lockState = CursorLockMode.Locked;
    }

    // Update is called once per frame
    void Update()
    {
        if (canvas.activeSelf) return;
        if (Mouse.current != null)
        {
            Vector2 mMov = Mouse.current.delta.ReadValue();
            
            rotX += mMov.x * mouseSens;
            rotY -= mMov.y * mouseSens;
            rotY = Mathf.Clamp(rotY, -90f, 90f);

            transform.localRotation = Quaternion.Euler(rotY, rotX, 0f);
        }


        if (Keyboard.current != null)
        {
            float x = 0f;
            float z = 0f;


            if (Keyboard.current.wKey.isPressed) z += 1f;
            if (Keyboard.current.sKey.isPressed) z -= 1f;
            if (Keyboard.current.dKey.isPressed) x += 1f;
            if (Keyboard.current.aKey.isPressed) x -= 1f;


            Vector3 mov = (transform.right * x) + (transform.forward * z);
            transform.position += mov * movSpeed * Time.deltaTime;


            if (Keyboard.current.escapeKey.wasPressedThisFrame)
            {
                Cursor.lockState = CursorLockMode.None;
            }
        }
    }
}

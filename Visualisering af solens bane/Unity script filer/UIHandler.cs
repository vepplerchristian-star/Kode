using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.UI;
public class UIHandler : MonoBehaviour
{
    public GameObject canvas;
    public Slider sunSpeedSlider;
    public GameObject sunControllerObject;
    private SunController sunConScript;

    [SerializeField] private InputActionReference toggleActionReference;

    void Start()
    {
        sunConScript = sunControllerObject.GetComponent<SunController>();
    }
    private void OnEnable()
    {
        if (toggleActionReference != null)
        {
            toggleActionReference.action.started += OnTogglePressed;
            toggleActionReference.action.Enable();
        }
    }

    private void OnDisable()
    {
        if (toggleActionReference != null)
        {
            toggleActionReference.action.started -= OnTogglePressed;
            toggleActionReference.action.Disable();
        }
    }

    private void OnTogglePressed(InputAction.CallbackContext context)
    {
        ToggleUI();
    }

    public void ToggleUI()
    {
        if (canvas == null) return;

        bool isActive = !canvas.activeSelf;
        canvas.SetActive(isActive);

        if (isActive)
        {
            Cursor.lockState = CursorLockMode.None;
            Cursor.visible = true;
        }
        else
        {
            Cursor.lockState = CursorLockMode.Locked;
            Cursor.visible = false;
        }
    }

    void Update()
    {
        sunConScript.dayLengthInSeconds = 1 / Mathf.Pow(sunSpeedSlider.value, 3f);
    }
}

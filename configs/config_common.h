static app_info app_industrial_control_sitara = {
    .qml_source = "industrial_control_sitara.qml",
    .name = "Industrial HMI",
    .icon_source = "/images/hmi.png"
};

static app_info app_camera = {
    .qml_source = "camera.qml",
    .name = "Camera",
    .icon_source = "/images/camera.png"
};

static app_info app_arm_analytics = {
    .qml_source = "arm_analytics.qml",
    .name = "ARM Analytics",
    .icon_source = "/images/analytics.png"
};

static app_info app_benchmarks = {
    .qml_source = "benchmarks.qml",
    .name = "Benchmarks",
    .icon_source = "/images/benchmarks.png"
};

static app_info app_gpu_performance = {
    .qml_source = "gpu_performance.qml",
    .name = "GPU Performance",
    .icon_source = "/images/gpu_performance.png"
};

static app_info app_seva_store = {
    .qml_source = "seva_store.qml",
    .name = "Seva Store",
    .icon_source = "/images/seva_store.png"
};

static app_info app_chromium_browser = {
    .qml_source = "chromium_browser.qml",
    .name = "Chromium",
    .icon_source = "/images/chromium.png"
};

static app_info app_3d_demo = {
    .qml_source = "3d_demo.qml",
    .name = "3D Demo",
    .icon_source = "/images/3d.png"
};

static app_info app_settings = {
    .qml_source = "settings.qml",
    .name = "Settings",
    .icon_source = "/images/settings.png"
};

static app_info app_terminal = {
    .qml_source = "terminal.qml",
    .name = "Terminal",
    .icon_source = "/images/terminal.png"
};

static app_info app_wifi = {
    .qml_source = "wifi.qml",
    .name = "Wifi",
    .icon_source = "/images/wifi.png"
};

static app_info app_industrial_control = {
    .qml_source = "industrial_control.qml",
    .name = "Industrial HMI",
    .icon_source = "/images/hmi.png"
};

static app_info app_live_camera = {
    .qml_source = "live_camera.qml",
    .name = "Live Camera",
    .icon_source = "/images/camera.png"
};

static app_info app_benchmarks_jacinto = {
   .qml_source = "benchmarks_jacinto.qml",
   .name = "Benchmarks",
   .icon_source = "/images/benchmarks.png"
};

static app_info app_industrial_control_minimal = {
    .qml_source = "industrial_control_minimal.qml",
    .name = "Industrial HMI",
    .icon_source = "/images/hmi.png"
};

static power_actions action_shutdown = {
    .name = "Shutdown",
    .command = "shutdown",
    .args = {"now"},
    .icon_source = "/images/shutdown.png",
};

static power_actions action_reboot = {
    .name = "Reboot",
    .command = "reboot",
    .args = {},
    .icon_source = "/images/reboot.png",
};

static power_actions action_suspend = {
    .name = "Suspend",
    .command = "/opt/ti-apps-launcher/suspend",
    .args = {},
    .icon_source = "/images/suspend.png",
};

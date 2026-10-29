# Lav først en 3d graf af solen ved forskellige tidspunkter på dagen.

from datetime import datetime, timezone
from astral import LocationInfo
from astral.location import Location
import plotly.graph_objects as go
import numpy as np

def get_sun_position(timestamp): 
    loc = LocationInfo("Solar", "Denmark", "Europe", 55.753, 8.920)
    target_time = datetime.fromtimestamp(timestamp, timezone.utc)
    location = Location(loc)
    az = location.solar_azimuth(target_time) # Grader med uret fra nord (horisontalt)
    el = location.solar_elevation(target_time) # Grader fra horizonten (vertikalt, hvor negative værdier betyder, at solen er nede)
    return az, el



current_date = datetime(2026, 10, 29, 12, 13)
print(get_sun_position(current_date.timestamp()))

times = [get_sun_position(datetime(2026, 10, 29, x, 0).timestamp()) for x in range(24)]
times = np.array(times)
times = times[times[:, 1] > 0]
x = np.cos(np.deg2rad(times[:, 0])) * np.cos(np.deg2rad(times[:, 1])) 
y = np.sin(np.deg2rad(times[:, 0])) * np.cos(np.deg2rad(times[:, 1])) 
z = np.sin(np.deg2rad(times[:, 1]))



fig = go.Figure(data=[go.Scatter3d(z=z, x=x, y=y, mode="markers")])

fig.update_layout(
    title='3D Surface Plot',
    scene=dict(
        xaxis_title='X Axis',
        yaxis_title='Y Axis',
        zaxis_title='Z Axis'
    )
)

# Export to HTML
fig.write_html('interactive_3d_surface.html')
fig.show()
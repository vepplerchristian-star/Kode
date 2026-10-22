import sys
from datetime import datetime, timezone
from astral import LocationInfo
from astral.location import Location

def get_sun_position(timestamp): # Kan findes hvis man søger på UNIX timestamp (Sekunder siden 1970 1 januar)
    loc = LocationInfo("Solar", "Denmark", "Europe", 55.753, 8.920)
    target_time = datetime.fromtimestamp(timestamp, timezone.utc)
    location = Location(loc)
    az = location.solar_azimuth(target_time) # Grader med uret fra nord (horisontalt)
    el = location.solar_elevation(target_time) # Grader fra horizonten (vertikalt, hvor negative værdier betyder, at solen er nede)
    return az, el

if __name__ == "__main__":
    if len(sys.argv) > 1:
        try:
            timestamp = int(sys.argv[1])
            az, el = get_sun_position(timestamp)
            print(f"{az:.2f} {el:.2f}")
        except ValueError:
            print("Argumentet skal være et heltal")
    else:
        print("Der mangler et argument.\n Et eksempel på et argument kunne være: python calc_sun_pos.py 12345678")
    
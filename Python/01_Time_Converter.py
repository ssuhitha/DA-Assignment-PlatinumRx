def convert_minutes(total_minutes):
    """Convert integer minutes to human-readable format."""
    hours = total_minutes // 60
    minutes = total_minutes % 60

    if hours == 0:
        return f"{minutes} minutes"
    elif minutes == 0:
        return f"{hours} hrs"
    else:
        return f"{hours} hrs {minutes} minutes"

# Test cases
test_values = [130, 110, 60, 45, 200, 0]
for val in test_values:
    print(f"{val} → {convert_minutes(val)}")

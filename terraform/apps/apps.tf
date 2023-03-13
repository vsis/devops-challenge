variable "timezone" {
  default = "Europe/Madrid"
}

data "http" "time" {
  url = "https://timeapi.io/api/Time/current/zone?timeZone=${var.timezone}"
  /* Example output
    {
    "year": 2023,
    "month": 1,
    "day": 19,
    "hour": 3,
    "minute": 56,
    "seconds": 9,
    "milliSeconds": 364,
    "dateTime": "2023-01-19T03:56:09.3644979",
    "date": "01/19/2023",
    "time": "03:56",
    "timeZone": "America/Los_Angeles",
    "dayOfWeek": "Thursday",
    "dstActive": false
  }
  */
}

resource "helm_release" "app1" {
  chart = "../../app1"
  name  = "app1"

  set {
    name  = "time"
    value = jsondecode(data.http.time.response_body).time # we actually want to decode json here
  }

  set {
    name  = "timezone"
    value = var.timezone
  }
}

# Output defined for testing
output "time_api" {
  description = "Data returned by time api"
  value       = data.http.time.response_body
}

output "release_name" {
  description = "Name of Helm release"
  value       = helm_release.app1.name
}

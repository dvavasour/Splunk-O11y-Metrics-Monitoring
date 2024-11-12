resource "signalfx_detector" "mod5_lab5a_det1" {
  name = "DV Max Hourly CPU Utilization % Detector"
  program_text = <<-EOT
  	       A = data('cpu.utilization', rollup='max').max(cycle='hour', cycle_start='0m', partial_values=False).publish(label='A')
  	       detect(when(A > threshold(70), lasting='5m')).publish('DV Max Hourly CPU Utilization % Detector (TF)')
  	       EOT
  description = "blank description"
  rule {
    description = "The value of A is above 70 for 5m."
    detect_label = "DV Max Hourly CPU Utilization % Detector (TF)"
    disabled = false
    notifications = [ "Email,dunstanv+signalfx-alerts@gmail.com" ]
    parameterized_body = "It's all gone Pete Tong"
    parameterized_subject = "Look Out --- {{ruleSeverity}} Alert: {{{ruleName}}} ({{{detectorName}}}) DV"
    severity = "Critical"
    
  }
}

resource "signalfx_detector" "mod5_lab5a_det2" {
  name = "DV Terraform P99 Memory Utilisation Hosts by Service Type"
  program_text = <<-EOT
    A = data('memory.utilization').percentile(pct=99, by=['service_type']).publish(label='A')
    detect(when(A > threshold(90), lasting='5m')).publish('DV P99 Memory Utilisation Hosts by Service Type')
    EOT

  description = "more blankness"
  rule {
    description = "Too High Memory"
    detect_label = "DV P99 Memory Utilisation Hosts by Service Type"
    disabled = false
    notifications = [ "Email,dunstanv+signalfx-alerts@gmail.com" ]
    parameterized_body = "It's the memory thi time"
    parameterized_subject = "Losing your memory --- {{ruleSeverity}} Alert: {{{ruleName}}} ({{{detectorName}}}) DV"
    severity = "Critical"    
  }
}

resource "signalfx_detector" "mod5_lab5a_det3" {
  name = "DV Terraform Max Hourly Memory Util %"
  program_text = <<-EOT
    A = data('memory.utilization', rollup='max').max(cycle='hour', cycle_start='0m', partial_values=False).publish(label='A')
    detect(when(A > threshold(70), lasting='5m')).publish('DV Max-Mem')
    EOT

  description = "more blankness"
  rule {
    description = "Too High Memory"
    detect_label = "DV Max-Mem"
    disabled = false
    notifications = [ "Email,dunstanv+signalfx-alerts@gmail.com" ]
    parameterized_body = "It's Max Memmmmmm"
    parameterized_subject = "Memory Max --- {{ruleSeverity}} Alert: {{{ruleName}}} ({{{detectorName}}}) DV"
    severity = "Critical"    
  }
}

resource "signalfx_alert_muting_rule" "rool_mooter_one" {
  description = "DV Terraform Muting Rule"

  start_time = 1731086007
  stop_time  = 1731107605 # Defaults to 0

#  detectors = [signalfx_detector."mod5_lab5a_det1_id]

  filter {
    property       = "service_type"
    property_value = "Testing"
  }

}
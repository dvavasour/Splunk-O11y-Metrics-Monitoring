
resource "signalfx_dashboard" "mod3_lab3a_db1" {
  name            = "DV Infrastructure Dashboard"
  dashboard_group = signalfx_dashboard_group.mod3_lab3a.id

  time_range = "-30m"


 chart {
   chart_id = signalfx_time_chart.mod3_lab3a_chart1.id
   column   = 0
   row      = 0
   width    = 6
   height   = 1
 }
 
 chart {
   chart_id = signalfx_time_chart.mod3_lab3a_chart2.id
   column   = 6
   row      = 0
   width    = 6
   height   = 1
 }
 
 chart {
   chart_id = signalfx_time_chart.mod3_lab3a_chart3.id
   column   = 0
   row      = 1
   width    = 6
   height   = 1
 }


chart {
  chart_id = signalfx_text_chart.mod3_lab3a_note1.id
  column = 6
  row = 1
  width = 6
  height = 1
}
 
 chart {
   chart_id = signalfx_time_chart.mod3_lab3c_chart4.id
   column   = 0
   row      = 2
   width    = 6
   height   = 1
 }
 
 chart {
   chart_id = signalfx_single_value_chart.mod3_lab3c_chart5.id
   column   = 6
   row      = 2
   width    = 6
   height   = 1
 }
 
 chart {
   chart_id = signalfx_single_value_chart.mod4_lab1_chart6.id
   column   = 0
   row      = 3
   width    = 6
   height   = 1
 }
 
 chart {
   chart_id = signalfx_single_value_chart.mod4_lab1_chart7.id
   column   = 6
   row      = 3
   width    = 6
   height   = 1
 }
 
 chart {
   chart_id = signalfx_list_chart.mod4_lab1_chart8.id
   column   = 0
   row      = 4
   width    = 6
   height   = 1
 }
 
 chart {
   chart_id = signalfx_time_chart.mod5_lab5a_chart9.id
   column   = 0
   row      = 5
   width    = 6
   height   = 1
 }

}

resource "signalfx_text_chart" "mod3_lab3a_note1" {
  name        = "Placeholder"
  description = "Lorem ipsum dolor sit amet, laudem tibique iracundia at mea. Nam posse dolores ex, nec cu adhuc putent honestatis"

  markdown = <<-EOF

# Hello from Dunstan

Placeholder text to force DB creations
    EOF
}


resource signalfx_time_chart "mod3_lab3a_chart1" {
  name = "DV Mean latency for Artemis Arts"

  program_text = <<-EOT
        A = data('dem_latency', filter=filter('dem_cust', 'Artemis Arts')).mean().publish(label='A')
        EOT

#  time_range = 3600
  plot_type = "LineChart"
  axes_precision = 2
  show_data_markers = true
}


resource signalfx_time_chart "mod3_lab3a_chart2" {
  name = "DV Peak latency for Artemis Arts"

  program_text = <<-EOT
        A = data('dem_latency', filter=filter('dem_cust', 'Artemis Arts')).max().publish(label='A')
        EOT

#  time_range = 3600
  plot_type = "LineChart"
  axes_precision = 2
  show_data_markers = true
}

resource signalfx_time_chart "mod3_lab3a_chart3" {
  name = "DV Total API Calls for Checkout"

  program_text = <<-EOT
        A = data('dem_numcalls').sum().publish(label='A')
        EOT

  plot_type = "LineChart"
  axes_precision = 2
  show_data_markers = true
  viz_options {
    color = "emerald"
    label = "A"
  }
}

resource signalfx_time_chart "mod3_lab3c_chart4" {
  name = "DV P99 CPU Utilisation"

  program_text = <<-EOT
	A = data('cpu.utilization').percentile(pct=99).publish(label='A')
        EOT

  plot_type = "LineChart"
  axes_precision = 2
  show_data_markers = true
  viz_options {
    color = "emerald"
    label = "A"
  }
}

resource signalfx_single_value_chart "mod3_lab3c_chart5" {
  name = "DV Latest P99 CPU Utilisation"

  program_text = <<-EOT
	A = data('cpu.utilization').percentile(pct=99).publish(label='A')
        EOT

  viz_options {
    color = "emerald"
    label = "A"
    value_suffix = "%"
  }
  color_by = "Scale"
  color_scale {
    color = "lime_green"
    lte = 50
  }
  color_scale {
    color = "yellow"
    gt = 50
    lte = 80
  }
  color_scale {
    color = "red"
    gt = 80
  }
}



resource signalfx_single_value_chart "mod4_lab1_chart6" {
  name = "DV Peak Latency for Artemis Arts no transform"

  program_text = <<-EOT
	A = data('dem_latency', filter=filter('dem_cust', 'Artemis Arts'), rollup='max').max().publish(label='A')
        EOT
  secondary_visualization = "Sparkline"

  viz_options {
    color = "emerald"
    label = "A"
    value_suffix = "%"
  }
  color_by = "Scale"
  color_scale {
    color = "lime_green"
    lte = 25
  }
  color_scale {
    color = "red"
    gt = 25
  }
}


resource signalfx_single_value_chart "mod4_lab1_chart7" {
  name = "DV Peak Latency for Artemis Arts with max over hour window"

  program_text = <<-EOT
	A = data('dem_latency', filter=filter('dem_cust', 'Artemis Arts'), rollup='max').max().max(over='1h').publish(label='A')
        EOT
  secondary_visualization = "Sparkline"
  viz_options {
    color = "emerald"
    label = "A"
    value_suffix = "%"
  }
  color_by = "Scale"
  color_scale {
    color = "lime_green"
    lte = 25
  }
  color_scale {
    color = "red"
    gt = 25
  }
}


resource signalfx_list_chart "mod4_lab1_chart8" {
  name = "DV Peak Latency for Each Sevice - Lasthour"

  program_text = <<-EOT
	A = data('dem_latency', filter=filter('dem_cust', 'Artemis Arts'), rollup='max').max(over='1h').publish(label='dem_latency')
        EOT
  max_precision = 4
}




resource signalfx_time_chart "mod5_lab5a_chart9" {
  name = "DV Max Hourly CPU Utilization %"

  program_text = <<-EOT
	A = data('cpu.utilization', rollup='max').max(cycle='hour', cycle_start='0m', partial_values=False).publish(label='A')
        EOT

#  time_range = 3600
  plot_type = "ColumnChart"
  axes_precision = 2
  show_data_markers = true
}
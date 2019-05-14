HTMLWidgets.widget({

  name: 'd3plus',

  type: 'output',

  initialize: function(el, width, height) {
    return {};
  },

  renderValue: function(el, x, instance) {

    document.getElementById(el.id).innerHTML = "";

    var data = HTMLWidgets.dataframeToD3(x.data) || false;

    console.log(x);
    console.log(data);

    window.x = x;
    window.el = el;

    var chart;

    switch (x.type) {
      case "area":
        chart = new d3plus.AreaPlot();
        break;
      case "bar":
        chart = new d3plus.BarChart();
        break;
      case "donut":
        chart = new d3plus.Donut();
        break;
      case "geomap":
        chart = new d3plus.Geomap();
        break;
      case "line":
        chart = new d3plus.LinePlot();
        break;
      case "network":
        chart = new d3plus.Network();
        break;
      case "pie":
        chart = new d3plus.Pie();
        break;
      case "point":
        chart = new d3plus.Plot();
        break;
      case "stacked":
        chart = new d3plus.StackedArea();
        break;
      case "treemap":
        chart = new d3plus.Treemap();
        break;
        
      /* Box is not working */
      /* TypeError: d3plus.BoxWhisker is not a constructor */
      case "box":
        chart = new d3plus.BoxWhisker();
        break;
      default:
        chart = null;
    }

    if (data) {
      chart.data(data);
    }
    
    if (x.groupBy) {
      chart.groupBy(x.groupBy);
    }
    
    // sum means "size" in D3plus 2
    if (x.sum) {
      chart.sum(x.sum);
    }
    
    if (x.legendConfig) {
      chart.legendConfig(x.legendConfig);
    }
    
    if (x.tooltipConfig) {
      chart.tooltipConfig(x.tooltipConfig);
    }
    
    if (x.shapeConfig) {
      chart.shapeConfig(x.shapeConfig);
    }

    // bar/line/area specific parameters
    if (x.xaxis) {
      chart.x(x.xaxis);
    }
    if (x.yaxis) {
      chart.y(x.yaxis);
    }
    
    // geomap specific parameters
    if (x.topojsonId) {
      chart.topojsonId(x.topojsonId);
    }
    if (x.topojson) {
      chart.topojson(x.topojson);
    }
    if (x.colorScale) {
      chart.colorScale(x.colorScale);
    }
    
    // loading/resize message
    if (x.loadingHTML) {
      chart.loadingHTML(x.loadingHTML);
    } else {
      chart.loadingHTML(
        `
        <div style='background-color: rgba(211,211,211,0.7)'>
          <sub style='margin-top: 0;'>Resizing...</sub>
        </div>  
      `
      );
      
      chart._messageStyle = {
        "left": "2px",
        "position": "absolute",
        "text-align": "left",
        "top": "2px",
        "width": "60px"
      };
    }
    
    chart.select("#" + el.id);

    setTimeout(function() {
      chart.render();
    }, 10);

  }

});

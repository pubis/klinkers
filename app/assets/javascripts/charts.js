$(function() {
	var r = Raphael("piechart", 400, 200);
	
	// Grab the data
  var labels = [],
      data = [];
  $("#data td.cat_name").each(function () {
      labels.push($(this).html());
  });
  $("#data td.cat_amount").each(function () {
      data.push(parseFloat($(this).html()));
  });


	var pie = r.piechart(100, 100, 80, data, { legend: labels });
	pie.hover(function () {
		this.sector.stop();
		this.sector.scale(1.1, 1.1, this.cx, this.cy);
		
		if (this.label) {
			this.label[0].stop();
			this.label[0].attr({ r: 7.5 });
			this.label[1].attr({ "font-weight": 800});
		}
	}, function () {
		this.sector.animate({ transform: 's1 1 ' + this.cx + ' ' + this.cy }, 500, "bounce");
		
		if (this.label) {
			this.label[0].animate( { r: 5 }, 500, "bounce");
			this.label[1].attr({ "font-weight": 400});
		}
	});
	
});
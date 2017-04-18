height = 24;
thickness = 4;
innerRadius = 11;
outerRadius = 13;
gapWidth = 4;
gapDepth = 10;
gapHeight = 15;
gapNumber = 5;
holeRadius = 3;

difference() {
	union() {
		cylinder(h = height, r = innerRadius);  // inside part of the plug
        cylinder(h = thickness, r = outerRadius); // outside part of the plug
	}
    
    // cut out a hole in the middle of the plug
	translate([0, 0, thickness]) cylinder(r = innerRadius - thickness, h = height);
    
    // for each gap - cut it out
	for (i = [1 : gapNumber]) {
		rotate([0, 0, i / gapNumber * 360]) translate([0, 0, height - gapHeight]) cube([outerRadius, gapWidth, gapHeight]);
	}
    
    sphere(r = holeRadius);
}

baseCurveRadius = thickness / 2;

// smoothen outside surface of the plug
translate([0, 0, baseCurveRadius]) { 
    rotate_extrude($fn = 200) translate([outerRadius, 0, 0]) circle(r = baseCurveRadius, $fn = 200);
}


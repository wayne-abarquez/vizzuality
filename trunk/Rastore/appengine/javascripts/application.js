$(document).ready(function() {
	
            function createPage(n, pg){
                var offset = (n * (pg-1));
                var url = "http://smoothraster.appspot.com/api?limit=" + n + "&offset=" + offset + "&callback=?";
                var page;
                if (pg==1) {
                    page = $('#slider ul li');
                } else {
                    page = $('<li></li>');
                    page.appendTo($('#slider ul'));
                }
                
                $.getJSON(url,
                    function(data){
                      var ct = 0;
                      $.each(data.items, function(i,item){
                          var ndiv = $('<div></div>');
                          console.log(ct);
                          if (ct==2){ ndiv.attr("class","last") };
                          if (ct>2){ 
                              if (ct==5){ndiv.attr("class","second last")
                              } else {ndiv.attr("class","second") };
                          }
                          
                          var nimg = $('<img />');
                          if (item.status == "complete"){
                            nimg.attr("src", "http://commondatastorage.googleapis.com/raster-server-private-tiles/" + item.k +"/z0/0/0.png");
                          } else {
                            nimg.attr("src", "http://mol.colorado.edu/tiles/" + item.k +"/z0/0/0.png");
                          } 
                          var nbra = $('<a></a>');
                          nbra.attr({"class": "title","href": "/viewer?k="+item.k})
                          nbra.append(nimg);
                          ndiv.append(nbra);
                          
                          var ntit = $('<a></a>');
                          ntit.attr({"class": "title","href": "/viewer?k="+item.k})
                          ntit.html(item.taxon + " / " + item.year);
                          ndiv.append(ntit);
                          
                          var nauth = $('<p></p>');
                          nauth.attr("class","author");
                          var auth = "by";
                          for (a in item.authors){
                              auth = auth + " " + item.authors[a];
                          }
                          nauth.html(auth);
                          ndiv.append(nauth);
                          
                          var ndes = $('<p></p>');
                          ndes.attr("class","description");
                          ndes.html(item.description);
                          ndiv.append(ndes);
                          
                          ndiv.appendTo(page);
                          
                          if (ct==2) {
                            $('<div class="line"></div>').appendTo(page);
                          }
                          
                          ct++;
                      });
                      //page.appendTo(cont);
                    });
                }
                
                
    var pages = 10;
    var pg = 1;
    while (pg <= pages){
      createPage(6, pg);
      pg++;
    }
          
      
	$("#slider").easySlider({
		auto: false, 
		continuous: true,
		numeric: true,
		numericId: 'controls'
	});
    
			
	// MODEL COMBO
		
	// <div id="program_combo">
	// 		<a class="program">Program</a>
	// 
	// 		<div id="activated_list">
	// 			<a class="program_others"></a>
	// 			<ul>						
	// 				<li><a class="other_program" href="#">Program 1</a></li>
	// 				<div class="line_split"></div>
	// 				<li><a class="other_program" href="#">Program 2</a></li>
	// 				<div class="line_split"></div>
	// 				<li class="last"><a class="other_program" href="#">Program 3</a></li>
	// 			</ul>
	// 		</div>
	// 	</div>
	// 	
	
});

// JavaScript Document
(function($){  
    $.extend($.fn, {  
        
		leftKeyDown:function(e)
			{
				var e = window.event || e;
				var value = e.button;
				if(value == 2 || value ==3)
					return false;
				else
				   return true;	
			},
		
		jQueryPie: function(ps){ 
        	        
            var target = (typeof ps.target == 'string' ? $(ps.target) : ps.target);         

            var pic = new Array(ps.pics.length);             
            for(var i = 0; i < ps.pics.length; i++)
            {
                var ii = new Image();
                ii.src = ps.pics[i];
				ii.galleryImg = "no";
				ii.style.height = ps.imgH + "px";
				ii.style.width = ps.imgW + "px"
                pic[i] = ii;
            } 
            


            function loadPic(n)
            {

                target.empty();
                target.append(pic[n]); 
                var currPic = target.first();
                currPic.bind("dragstart", function() { return false; });
            }

            loadPic(0);

            var prev = 0, curr = 0; 
  
            function checkRegion(e)
            {   
     
                var dx = e.pageX - ps.ox - target.offset().left;
                var dy = e.pageY - ps.oy - target.offset().top;
                var d = Math.sqrt(dx * dx + dy * dy);

                if(d > ps.rMin && d < ps.rMax)
                {
                    var angle = Math.acos(dx / d) * 57.3;

                    if(dy > 0)
                    {
                        angle = 360 - angle;
                    }

                    angle = angle + 180 / (ps.pics.length - 1);

                    if(angle >= 360)
                    {
                        angle = angle - 360;
                    }

                    curr = Math.floor((ps.pics.length - 1) * angle / 360) + 1;

                    if(prev != curr)
                    {  
						ps.onChanging(ps.codeVal[curr-1]);
                        loadPic(curr);
                        prev = curr;
                    }
                }
            }  
     
            function recovery(e)
            {   

                $(document).unbind('mousemove', checkRegion);
                $(document).unbind('mouseup', recovery);
                $(target).unbind('mouseleave', recovery);
                ps.onStop(curr);
                loadPic(0);
                prev = curr = 0;
            }; 

            function md(e) 
            {
				if($.fn.leftKeyDown(e))
				{
					$(document).bind('mousemove', checkRegion);
					$(document).bind('mouseup', recovery);
					$(target).bind('mouseleave', recovery);
					e.preventDefault();
					checkRegion(e);
				}
            } 
            target.bind('mousedown', md);   
        },
		
		
		controlButton: function(bu){
			var target = (typeof bu.target == 'string' ? $(bu.target) : bu.target);
			//target.css("cursor", "pointer"); 
			var pic = new Array(bu.pics.length);             
			for(var i = 0; i < bu.pics.length; i++)
			{
				var ii = new Image();				
				ii.galleryImg = "no";
				ii.alt = bu.alt[bu.language];
				ii.title = bu.alt[bu.language];
				ii.style.height = bu.imgH + "px";
				ii.style.width = bu.imgW + "px"
				ii.src = bu.pics[i];

				pic[i] = ii;
			}
			
			function loadpic(n)
			{
				target.empty();
                target.append(pic[n]); 
                target.first().bind("dragstart", function() { return false; });	
			}
//			loadpic(0);
			
			function stopfun(e)
			{
				$(document).unbind('mouseup',stopfun);
				loadpic(0);	
				bu.mupfunc();	
				
			}
			

			function md(e)
			{
				if($.fn.leftKeyDown(e))
				{
					$(document).bind('mouseup',stopfun);
					e.preventDefault();
					loadpic(1);
					bu.mdfunc();
				}
 			}
			
			target.bind('mousedown',md);
			loadpic(0);
		},
		
		jQueryMenu: function(ps){ 
        	        
            var target = (typeof ps.target == 'string' ? $(ps.target) : ps.target);         

            var pic = new Array(ps.pics.length);             
            for(var i = 0; i < ps.pics.length; i++)
            {
                var ii = new Image();
                ii.src = ps.pics[i];
				ii.galleryImg = "no";
				ii.style.height = ps.imgH + "px";
				ii.style.width = ps.imgW + "px"
                pic[i] = ii;
            } 
           
            function mLoadPic(n)
            {
                target.empty();
                target.append(pic[n]); 
                var currPic = target.first();
                currPic.bind("dragstart", function() { return false; });
            }

            mLoadPic(0);

            var prev = 0, curr = 0; 
  
            function mCheckRegion(e)
            {   
     
                var dx = e.pageX - ps.ox - target.offset().left;
                var dy = e.pageY - ps.oy - target.offset().top;
                var d = Math.sqrt(dx * dx + dy * dy);
				
                if(d > ps.rMin && d < ps.rMax)
                {
                    var angle = Math.acos(dx / d) * 57.3;
					
                    if(dy > 0)
                    {
                        angle = 360 - angle;
                    }

                    angle = angle + 180 / (ps.pics.length - 2);

                    if(angle >= 360)
                    {
                        angle = angle - 360;
                    }
					
                    curr = Math.floor((ps.pics.length - 2) * angle / 360) + 1;
					
					if(curr != 2 && curr != 4 && curr != 8)
					{
						if(prev != curr)
                    	{  
							ps.onChanging(ps.codeVal[curr-1]);
                        	mLoadPic(curr);
                        	prev = curr;
                    	}
					} 
                }
				else 
				{
					curr = 9;
					if(prev != curr)
                    {  
						ps.onChanging(ps.codeVal[curr-1]);
                        mLoadPic(curr);
                        prev = curr;
                    }
				}
            }  
     
            function mRecovery(e)
            {   

                $(document).unbind('mousemove',mCheckRegion);
                $(document).unbind('mouseup', mRecovery);
                $(document).unbind('mouseleave', mRecovery);
                mLoadPic(0);
                prev = curr = 0;
            }; 

            function menud(e) 
            {
				if($.fn.leftKeyDown(e))
				{
					$(document).bind('mousemove', mCheckRegion);
					$(document).bind('mouseup', mRecovery);
					$(document).bind('mouseleave', mRecovery);
					e.preventDefault();
					mCheckRegion(e);
				}
            } 
            target.bind('mousedown', menud);   
        },
		
		menuButton: function(bu){
			var target = (typeof bu.target == 'string' ? $(bu.target) : bu.target);
			var pic = new Array(bu.pics.length);             
			for(var i = 0; i < bu.pics.length; i++)
			{
				var ii = new Image();				
				ii.galleryImg = "no";
				ii.alt = bu.alt[bu.language];
				ii.style.height = bu.imgH + "px";
				ii.style.width = bu.imgW + "px"
				ii.src = bu.pics[i];

				pic[i] = ii;
			}
			
			function mLoadpic(n)
			{
				target.empty();
                target.append(pic[n]); 
                target.first().bind("dragstart", function() { return false; });	
			}
			
			function mStopfun(e)
			{
				$(document).unbind('mouseup',mStopfun);
				mLoadpic(0);	
				bu.menuupfunc();	
				
			}
			

			function menud(e)
			{
				if($.fn.leftKeyDown(e))
				{
					$(document).bind('mouseup',mStopfun);
					e.preventDefault();
					mLoadpic(1);
					bu.menudfunc();
				}
 			}
			
			target.bind('mousedown',menud);
			mLoadpic(0);
		} 
    });  
})(jQuery); 


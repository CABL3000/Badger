<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name='layout' content='main'/>
  <title>${grailsApplication.config.projectID} | Ortholog search</title>
  <parameter name="search" value="selected"></parameter>
  <script src="${resource(dir: 'js', file: 'jqplot/jquery.min.js')}" type="text/javascript"></script>
  <script src="${resource(dir: 'js', file: 'DataTables-1.9.4/media/js/jquery.dataTables.js')}" type="text/javascript"></script>
  <script src="${resource(dir: 'js', file: 'TableTools-2.0.2/media/js/TableTools.js')}" type="text/javascript"></script>
  <script src="${resource(dir: 'js', file: 'TableTools-2.0.2/media/js/ZeroClipboard.js')}" type="text/javascript"></script>
  <link rel="stylesheet" href="${resource(dir: 'js', file: 'jqplot/jquery.jqplot.css')}" type="text/css"></link>
  <link rel="stylesheet" href="${resource(dir: 'js', file: 'DataTables-1.9.4/media/css/data_table.css')}" type="text/css"></link>
  <link rel="stylesheet" href="${resource(dir: 'js', file: 'TableTools-2.0.2/media/css/TableTools.css')}" type="text/css"></link>

  
  <script type="text/javascript"> 
    
   <% 
    def jsonData = searchRes.encodeAsJSON(); 
    println jsonData;
    %>

	/* scientific sorting functions for evalues */
        jQuery.fn.dataTableExt.oSort['scientific-asc']  = function(a,b) {
        	var x = parseFloat(a);
        	var y = parseFloat(b);
        	return ((x < y) ? -1 : ((x > y) ?  1 : 0));
        };
 
        jQuery.fn.dataTableExt.oSort['scientific-desc']  = function(a,b) {
        	var x = parseFloat(a);
        	var y = parseFloat(b);
        	return ((x < y) ? 1 : ((x > y) ?  -1 : 0));
        };
        	
  $(document).ready(function() {

    var oTable = $('#search_res').dataTable( {
        "bProcessing": true,
        "sPaginationType": "full_numbers",
    	"iDisplayLength": 10,
    	"aLengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
    	"oLanguage": {
    		"sSearch": "Filter records:"
    	},
    	"aaSorting": [[ 5, "asc" ]],
    	"aoColumns": [
			 null,
			 null,
			 null,
			 null,
			 null,
			 { "sType": "scientific" }
		],
    	"sDom": 'T<"clear">lfrtip',
        "oTableTools": {
        	"sSwfPath": "${resource(dir: 'js', file: 'TableTools-2.0.2/media/swf/copy_cvs_xls_pdf.swf')}"
        }
    } );
    
    var oTable = $('#bar_res').dataTable( {
        "bProcessing": true,
        "sPaginationType": "full_numbers",
    	"iDisplayLength": 10,
    	"aLengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
    	"oLanguage": {
    		"sSearch": "Filter records:"
    	},
    	"aaSorting": [[ 1, "asc" ]],
    	"sDom": 'T<"clear">lfrtip',
        "oTableTools": {
        	"sSwfPath": "${resource(dir: 'js', file: 'TableTools-2.0.2/media/swf/copy_cvs_xls_pdf.swf')}"
        }
    } );
    
    var oTable = $('#count_res').dataTable( {
        "bProcessing": true,
        "sPaginationType": "full_numbers",
    	"iDisplayLength": 10,
    	"aLengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
    	"oLanguage": {
    		"sSearch": "Filter records:"
    	},
    	"sType": "num-html",
    	"aaSorting": [[ 1, "asc" ]],
    	"sDom": 'T<"clear">lfrtip',
        "oTableTools": {
        	"sSwfPath": "${resource(dir: 'js', file: 'TableTools-2.0.2/media/swf/copy_cvs_xls_pdf.swf')}"
        }
    } );
    
     /* numbers in html sorting */
		jQuery.extend( jQuery.fn.dataTableExt.oSort, {
			"num-html-pre": function ( a ) {
				var x = a.replace( /<.*?>/g, "" );
				return parseFloat( x );
			},
		 
			"num-html-asc": function ( a, b ) {
				return ((a < b) ? -1 : ((a > b) ? 1 : 0));
			},
		 
			"num-html-desc": function ( a, b ) {
				return ((a < b) ? 1 : ((a > b) ? -1 : 0));
			}
		} );
    
 });
    </script>
  </head>

  <body>
  <div class="introjs-search-ortho_search">
<g:link action="">Search</g:link> > <g:link action="ortho">Search orthologs</g:link> > Search results
<g:if test="${params.type == 'bar'}">
<div data-intro='Results can be sorted by sequence frequency per species. Select a cluster ID to see more details' data-step='1'>
	<h1>Clusters with size ${params.val}:</h1>
	<table cellpadding="0" cellspacing="0" border="0" class="display" id="bar_res">
		<thead>
			<tr>
				<th>Cluster</th>
				<g:each var="res" in="${files}">
					<th><i>${res.genus[0]}. ${res.species}</i><br> (${res.file_name})</td>					
				</g:each>
			</tr>
		</thead>
		<tbody>
			<g:each var="res" in="${searchRes}">
				<tr><td><g:link action="cluster" params="${[group_id:res.group_id]}">${res.group_id}</g:link></td>
					<g:each var="s" in="${files}">
						<td>${res."${s.file_name}"}</td>
					</g:each>
				</td>
			</g:each>
		</tbody>
	</table>
</div>
</g:if>
<g:if test="${params.type == 'count'}">
	<g:if test="${searchRes}">
	<div data-intro='Results can be sorted by sequence frequency per species. Select a cluster ID to see more details' data-step='1'>
		<table cellpadding="0" cellspacing="0" border="0" class="display" id="count_res">
			<thead>
				<tr>
					<th>Cluster</th>
					<th>Size</th>
					<g:each var="res" in="${files}">
						<th><i>${res.genus[0]}. ${res.species}</i><br> (${res.file_name})</td>					
					</g:each>
				</tr>
			</thead>
			<tbody>
				<g:each var="res" in="${searchRes}">
					<tr><td><g:link action="cluster" params="${[group_id:res.group_id]}">${res.group_id}</g:link></td>
						<td>${res.size}</td>
						<g:each var="s" in="${files}">
							<td>${res."${s.file_name}"}</td>
						</g:each>
					</td>
				</g:each>
			</tbody>
		</table>
	</div>
	</g:if>
	<g:else>
		<br><br><h3>There are no ortholog groups with those numbers, please go <a href="previous.html" onClick="history.back();return false;">back</a> and try again</h3>
	</g:else>
</g:if>
<g:if test="${params.type == 'search'}">
	<g:if test="${searchRes}">
	<div data-intro='Search results show all ortholog clusters with a match to the search term in the annotation text. The highest scoring annotation per group is listed in the <b>Description</b> column. Select a transcript ID or cluster ID to see more details.' data-step='1'>
		<h1>Clusters with a description matching '${params.searchId}'</h1>		
		  <table cellpadding="0" cellspacing="0" border="0" class="display" id="search_res">
			<thead>
				<tr>
					<th>Cluster</th>
					<th>Size</th>
					<th>Species</th>
					<th>Transcript</th>
					<th>Description</th>
					<th>Score</th>
				</tr>
			</thead>
			<tbody>
				<g:each var="res" in="${searchRes}">
					<tr><td><g:link action="cluster" params="${[group_id:res.group_id]}">${res.group_id}</g:link></td>
					<td>${res.size}</td>
					<td><i>${res.genus[0]}. ${res.species}</i></td>
					<td><g:link action="m_info" params="${[mid: res.mrna_id]}"> ${res.mrna_id}</g:link></td>
					<td><span style="color:red">${res.anno_db}: </span><% if (res.descr.size()>200){ res.descr = res.descr[0..200]+" ... "};%>${res.descr}</td>
					<td>${res.score}</td>
					</tr>
				</g:each>
			</tbody>
		</table>
	</div>
	</g:if>
	<g:else>
		<br><br><h3>There were no results for your search of '${params.searchId}'. Please go <a href="previous.html" onClick="history.back();return false;">back</a> and try again</h3>
	</g:else>
</g:if>
</div>
</body>
</html>


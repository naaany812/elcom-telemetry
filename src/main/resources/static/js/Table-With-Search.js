//Table with search
$(document).ready(function() {
bindSearchTable("#search_modal","#counter_modal","#table_modal")
    
bindSearchTable("#search_window","#counter_window","#table_measures_content")
});
function bindSearchTable(searchId,counterId,tableId)
{
      $(searchId).keyup(function () {
    var searchTerm = $(searchId).val();
    var listItem = $(tableId+' tbody').children('tr');
    var searchSplit = searchTerm.replace(/ /g, "'):containsi('")
    
  $.extend($.expr[':'], {'containsi': function(elem, i, match, array){
        return (elem.textContent || elem.innerText || '').toLowerCase().indexOf((match[3] || "").toLowerCase()) >= 0;
    }
  });
    
  $(tableId+" tbody tr").not(":containsi('" + searchSplit + "')").each(function(e){
    $(this).attr('visible','false');
  });

  $(tableId+" tbody tr:containsi('" + searchSplit + "')").each(function(e){
    $(this).attr('visible','true');
  });

  var jobCount = $(tableId+' tbody tr[visible="true"]').length;
    $(counterId).text('Найдено: ' + jobCount);

  if(jobCount == '0') {$('.no-result').show();}
    else {$('.no-result').hide();}
		  });
};


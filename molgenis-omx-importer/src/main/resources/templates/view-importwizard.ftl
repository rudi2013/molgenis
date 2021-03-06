<#include "molgenis-header.ftl">
<#include "molgenis-footer.ftl">
<#assign css=["bwizard.min.css", "importwizard.css"]>
<#assign js=["bwizard.min.js"]>
<@header css js/>
	<div class="row-fluid">
				<div id="wizard">
				<ol>
					<#list wizard.pages as wizardPage>
						<li>${wizardPage.title}</li>
					</#list>
				</ol> 
				
				<#list wizard.pages as wizardPage>
					<div style="min-height: 180px">
						<p>			
							<#if wizardPage == wizard.currentPage && wizardPage.viewTemplate! != "">
								<#if wizard.errorMessage! != "" >
									<div class="alert alert-block alert-error">${wizard.errorMessage!}</div>
								</#if>	
								<#if wizard.validationMessage! != "" >
									<div class="alert alert-block alert-error">${wizard.validationMessage!}</div>
								</#if>	
								<#if wizard.successMessage! != "" >
									<div class="alert alert-block alert-success">${wizard.successMessage!}</div>
								</#if>
								<#include wizardPage.viewTemplate />
							</#if>
						</p>
					</div>
				</#list>
				
			</div>
		
		
	<script type="text/javascript">
		$("#wizard").bwizard({activeIndex: ${wizard.currentPageIndex}});
	   	$('.pager').css({"width" : "491px"});//Pager bar with previous/next buttons
	   	$(window).load(function() {
			var headerHeight = $("#header").height();
			var viewportHeight = $(window).height();
			var otherHeight = 358;//plugin title + menu + padding/progress bar etc of the wizard + footer
			var preferredImporterHeight = (viewportHeight - headerHeight - otherHeight);
	   		
			//TODO:isn't there a way to select those by wildcard? "step*" 
	   		$("#step1").height(preferredImporterHeight);
 			$("#step1").css({"overflow" : "scroll"});
 			$("#step2").height(preferredImporterHeight);
 			$("#step2").css({"overflow" : "scroll"});
 			$("#step3").height(preferredImporterHeight);
 			$("#step3").css({"overflow" : "scroll"});
	    });
	   //Add Cancel button
	   	$('<li role="button" class="cancel" ><a href="#">Restart</a></li>').css({"margin-left" : "230px"}).insertBefore('.next').click(function(){
	   		performAction(this, '${context_url}');
	   	});
	 
	   	//Remove bwizard default eventhandlers and add our own eventhandlers	
	   	
	   	$('.next').unbind('click').click(function(){
	   		<#if wizard.lastPage > 
	   			performAction(this, '${context_url}');
	   		<#else>
	   			performAction(this, '${context_url}/next');
	   		</#if>
	   	});
	   	
	   	$('.previous').unbind('click').click(function(){
	   		performAction(this, '${context_url}/previous');
	   	});
	   	
	   	<#if wizard.lastPage > 
	    	$('.next a').html('Finish');
	    </#if>
	    
	   	<#if wizard.validationMessage! == "">
	   		$('.next').removeClass('disabled');
	   		
	   		<#if wizard.lastPage > 
	   			$('.cancel').addClass('disabled');
	   			$('.previous').addClass('disabled');
	   		</#if>
	   		
	   	<#else>
	   		$('.next').addClass('disabled');
	   	</#if>
	   	
	   	<#if wizard.firstPage && wizard.errorMessage! == "">
	   		$('.cancel').addClass('disabled');
	   	</#if>
	   	 	
	   	function performAction(btn, action) {
	   		if (!$(btn).hasClass('disabled')) {
	   			<#if wizard.currentPageIndex == 1>
	   				$('#spinner').modal('show');
	   			</#if>
	   			
	   			document.forms.importWizardForm.action = action;
	   			document.forms.importWizardForm.submit();
	   		}
	   	}
	</script>
	</div>
<@footer/>
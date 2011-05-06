<%@ page language="VB" autoeventwireup="false" inherits="_Default, App_Web_voesobbb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<title>Contact Details</title>
<link rel="stylesheet" type="text/css" href="./styles/StyleSheet.css"/>
<script src="http://yui.yahooapis.com/2.8.0r4/build/yahoo-dom-event/yahoo-dom-event.js"></script>
<script src="http://yui.yahooapis.com/2.8.0r4/build/connection/connection-min.js"></script>
<script src="http://yui.yahooapis.com/2.8.0r4/build/json/json-min.js"></script>
<script>
          var makeRequest= {
            getDetails: function(strWS, funCB, strParams){
            //All calls to the Webservice go through here.
            YAHOO.util.Connect.setDefaultPostHeader(false);
            YAHOO.util.Connect.initHeader("Content-Type", "application/json; charset=utf-8");
	        var request = YAHOO.util.Connect.asyncRequest('POST', strWS, funCB, strParams);
            },
            successHandler: function(o){
            //As all responses populate the input boxes this is our SuccessHandler for the two calls
               if(o.responseText !== undefined){
               
                 try { 
                     var responseData = YAHOO.lang.JSON.parse(o.responseText);
                     alert(responseData.d);
                     var JSON = YAHOO.lang.JSON.parse(responseData.d); 

                      var EmailAddress  = document.getElementById('EmailAddress');
                      var FirstName = document.getElementById('FirstName');
                      var LastName = document.getElementById('LastName');
                            if (JSON.IsCompany === true){
                                // check for a true and perhaps do somethingelse
                            }
                            else{
                               EmailAddress.value = JSON.EmailAddress; 
                               FirstName.value = JSON.FirstName;
                               LastName.value = JSON.LastName;  
                            }
                        var PhoneDay = document.getElementById('PhoneDay');
                            PhoneDay.value = JSON.PhoneDay;
                        var Address1 = document.getElementById('Address1');
                            Address1.value = JSON.Address1;
                        var Address2 = document.getElementById('Address2');
                            Address2.value = JSON.Address2;
                        var Address3 = document.getElementById('Address3');
                            Address3.value = JSON.Address3;
                        var City = document.getElementById('City');
                            City.value = JSON.City; 
                        var County = document.getElementById('County');
                            County.value = JSON.County;
                        var PostalCode = document.getElementById('PostalCode');
                            PostalCode.value = JSON.PostalCode;  
                }  
                catch (e) {
                 //bounce onto the general error handler   
                  makeRequest.generalErrorHandler(e.message, 'Opps exception thrown');
                } 
               }
               else{
                 //bounce onto the general error handler   
                makeRequest.generalErrorHandler("undefined error exception",'Opps responseText Issue');
               }
            },
            handleFailure: function(o){
             //bounce onto the general error handler   
               makeRequest.generalErrorHandler(e.message,'Opps not handled Properly');
            },
            generalErrorHandler: function(Logme,Message){
            //General ErrorHandler
            //Could have a WebService that logs to a log file, assuming that the error you get back isn't that your WS is down.
                alert(Message);
            }
          };
     
     var updateContactDetails = {
        updateUserDetails: function(){
           var obj = {};
            obj.Address1 = document.getElementById("Address1").value;
            obj.Address2 = document.getElementById("Address2").value;
            obj.Address3 = document.getElementById("Address3").value;
            obj.City = document.getElementById("City").value;
            obj.CompanyName = "Company Name";
            obj.ContactName = "Contact Name";
            obj.County = document.getElementById("County").value;;
            obj.CustomerOwner = "Customer Owner";
            obj.DOB = "DOB";
            obj.EmailAddress = document.getElementById("EmailAddress").value;
            obj.FirstName = document.getElementById("FirstName").value;
            obj.IsCompany = false;
            obj.LastName = document.getElementById("LastName").value;
            obj.PhoneDay = document.getElementById("PhoneDay").value;
            obj.PostalCode = document.getElementById("PostalCode").value;
            obj.TitleID =3;
            var jsonStr = YAHOO.lang.JSON.stringify(obj); 
            objCNameAddress = '{"anotherParameter":"somevalue",objCNameAddress:'+ jsonStr +'}';
            makeRequest.getDetails('./WebService.asmx/fncWSUpdateProfileData', updateContactDetailsCallback, objCNameAddress);
        },
        modify: function(saveaction){
            if (saveaction === true){
               document.getElementById("buttonmodify").style.display = "none";
               document.getElementById("buttonactions").style.display = "block";
            }
            else{
               document.getElementById("buttonactions").style.display = "none";
               document.getElementById("buttonmodify").style.display = "block";
                
            }
       }
        
    };
    
     var contactDetails = {
            getUserDetails: function(){
	            makeRequest.getDetails('./WebService.asmx/GetProfileData', contactDetailsCallback, '{"strTargetSystem":"irl"}');
            }
        };
        
         //callbacks
          var updateContactDetailsCallback = {
              success:makeRequest.successHandler,
              failure:makeRequest.handleFailure
          };
          
          var contactDetailsCallback = {
              success:makeRequest.successHandler,
              failure:makeRequest.handleFailure
          };
    
   
    //Add Events  
    YAHOO.util.Event.addListener(window, "load", contactDetails.getUserDetails()); 
    YAHOO.util.Event.addListener("SaveContactDetails", "click", function(e){ YAHOO.util.Event.preventDefault(e);updateContactDetails.updateUserDetails();});
    YAHOO.util.Event.addListener("CancelModify", "click", function(e){ YAHOO.util.Event.preventDefault(e);YAHOO.util.Event.addListener("CancelModify", "click", updateContactDetails.modify(false));});
    YAHOO.util.Event.addListener("ModifyDetails", "click", function(e){ YAHOO.util.Event.preventDefault(e);YAHOO.util.Event.addListener("ModifyDetails", "click", updateContactDetails.modify(true));});
    </script>
</head>
<body class="yui-skin-sam">
<div>
  <h2>Contact Details</h2>

<h4>Below are the contact details we have for Customer.<br /></h4>
       <div class="leftside">
                  <span class="fieldlabel">First Name: </span><input type="text" id="FirstName"/> 
        </div>
        <div class="rightside">
                   <span class="fieldlabel">Last Name: </span><input type="text" id="LastName"/>
        </div>
        <div class="leftside">
                  <span class="fieldlabel">EmailAddress: </span><input type="text" id="EmailAddress"/>
        </div>
        <div class="rightside">
                   <span class="fieldlabel">Phone Day: </span><input type="text" id="PhoneDay"/>
        </div>
        <div class="leftside">
                  <span class="fieldlabel">Address 1: </span><input type="text" id="Address1"/>
        </div>
        <div class="rightside">
                   <span class="fieldlabel">City: </span><input type="text" id="City"/>
        </div>
        <div class="leftside">
                  <span class="fieldlabel">Address 2: </span><input type="text" id="Address2" />
        </div>
        <div class="rightside">
                    <span class="fieldlabel">County: </span><input type="text" id="County"/>
        </div>
        <div class="leftside">
                  <span class="fieldlabel">Address 3: </span><input type="text" id="Address3"/>
        </div>
        <div class="rightside">
                   <span class="fieldlabel">Postal Code: </span><input type="text" id="PostalCode"/>
        </div>
        <div id="buttonactions">
            <div class="leftside">
                <span id="btncancel"><a href="#cancel" title="Canel Modify" class="button" id="CancelModify">Canel</a></span>
            </div>
            <div class="rightside">
                <span id="btnsave"><a href="#save" title="Save Contact Details" class="button" id="SaveContactDetails">Save</a></span>
            </div>
        </div>
        <div id="buttonmodify"><span id="btnModify"><a href="#modify" title="Modify Contact Details" class="button" id="ModifyDetails">Modify</a></span></div>
       
  </div>
</body>
</html>

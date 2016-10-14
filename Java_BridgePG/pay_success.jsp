<%-- 
    Document   : pay_success
    Created on : 22 Jul, 2016, 2:21:18 PM
    Author     : sandeep
--%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.util.HashMap"%>
<% String pageName = "pay_success"; %>
<%@include file="jspf/header.jspf" %>
<%@page import="
    org.json.*,
    java.util.Map"
%>

	<section id="inner-headline">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<ul class="breadcrumb">
					<li><a href="index.html">Home</a><i class="icon-angle-right"></i></li>
					<li class="active">Pay</li>
				</ul>
			</div>
		</div>
	</div>
	</section>
	<section id="content">
<div class="container">

<div class="row">

	<div class="col-lg-6">
	<!-- call response -->
	
	<h4>Bridge Response</h4>
        <%
        String enc_vals = request.getParameter("bridgeResponseMessage");
        bridgeutil.BridgeCryptor bg = bridgeutil.BridgeFactory.getBridgeCryptor();

        bg.setKeys(bridgePrivateKey, bridgePublicKey);

        String dec_vals = bg.decrypt(enc_vals);

        Map vals = new HashMap<String, Object>();
        String []t1 = {"a1", "a2", "a3"};
        vals.put("key1", "value1");
        vals.put("key2", t1);
        vals.put("key3", "value3");
        
        %>
            <pre class="prettyprint linenums">
                    print the response string 

                    Encrypted Values:  
                    <%= enc_vals %>
                    <br>

                    Decrypted Values:
                    <%= dec_vals %>

            </pre>
	</div>

	<div class="col-lg-6">
	</div>
</div>

	<!-- payment response status -->
<%
String arr_enquiry_p[] = {
    "merchant_txn"
};

String arr_status_p[] = {
    "merchant_txn",
    "csc_txn"
};

String arr_refund_log_p[] = {
    "merchant_txn"       ,
    "csc_txn"            ,
    "product_id"         ,
    "merchant_txn_status",
    "merchant_reference" ,
    "refund_deduction"   ,
    "refund_mode"        ,
    "refund_type"        ,
    "refund_trigger"     ,
    "refund_reason" 
};

String arr_refund_status_p[] = {
    "merchant_txn"       ,
    "csc_txn"            ,
    "refund_reference"
};

String arr_recon_log_p[] = {
    "merchant_txn"       ,
    "csc_txn"            ,
    "refund_reference"   ,
    "cscuser_id"         ,
    "product_id"         ,
    "txn_amount"         ,
    "merchant_date"      ,
    "merchant_txn_status",
    "merchant_reciept"
};

Map<String, Object> api_calls = new HashMap<String, Object>();
api_calls.put("enquiry", arr_enquiry_p);
api_calls.put("status", arr_status_p);
api_calls.put("refund_log", arr_refund_log_p);
api_calls.put("refund_status", arr_refund_status_p);
api_calls.put("recon_log", arr_recon_log_p);


Map<String, String> api_inputs = new HashMap<String, String>();
api_inputs.put("merchant_txn", "Merchant Transaction");
api_inputs.put("csc_txn", "Bridge Transaction");
api_inputs.put("product_id", "Product ID");
api_inputs.put("merchant_txn_status", "Merchant Transaction Status");
api_inputs.put("merchant_reference", "Merchant Reference");
api_inputs.put("refund_deduction", "Refund Deduction");
api_inputs.put("refund_mode", "Refund Mode");
api_inputs.put("refund_type", "Refund Type");
api_inputs.put("refund_trigger", "Refund Trigger");
api_inputs.put("refund_reason", "Refund Reason");
api_inputs.put("refund_reference", "Refund Reference");
api_inputs.put("cscuser_id", "VLE ID (USER)");
api_inputs.put("txn_amount", "Transaction Amount");
api_inputs.put("merchant_date", "Merchsnt Date");
api_inputs.put("merchant_reciept", "Merchsnt Receipt");

JSONObject api_calls_json = new JSONObject(vals);
String api_calls_str = api_calls_json.toString();

Map<String, String> posted_vals = new HashMap<String, String>();
StringTokenizer st = new StringTokenizer(dec_vals, "|");
while(st.hasMoreTokens()){
    String nc = st.nextToken();
    if(nc.trim().length() <= 0 )
        continue;
    StringTokenizer st2 = new StringTokenizer(nc, "=");
    String cKey = st2.hasMoreTokens()?st2.nextToken():"";
    String cVal = st2.hasMoreTokens()?st2.nextToken():"";
    posted_vals.put(cKey, cVal);
}

JSONObject posted_json = new JSONObject(posted_vals);
String posted_val_str = posted_json.toString();

%>

		<div class="row">
			<div class="col-md-8 col-lg-8 col-xl-8 col-sm-12 col-xs-12 bg">
				<h4>CSC PG Respponse</h4><hr>
<% for (Map.Entry<String, String> apiParam : api_inputs.entrySet()) { %>
				<div class="col-md-12 col-lg-12 col-xl-12 col-sm-12 col-xs-12 padding-btm">
					<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
						<label class="control-label"><strong><%= apiParam.getValue() %>:</strong></label>
					</div>	
					<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">						
						<input id="api_input_<%= apiParam.getKey() %>" name="api_input_<?php echo $iid; ?>" type="text" value="" class="form-control">
					</div>
				</div>
<% } %>				
			</div>
			<div class="col-md-2 col-lg-2 col-xl-2 col-sm-12 col-xs-12 bg">
				<h4>CSC PG Action</h4><hr>
<% for (Map.Entry<String, Object> entry : api_calls.entrySet()) { %>
				<div class="col-md-12 col-lg-12 col-xl-2 col-sm-12 col-xs-12 padding-btm">
                                    <input type="button" name="btn_<%= entry.getKey() %>" value="<%= entry.getKey() %>" id="btn_<%= entry.getKey() %>" class="btn btn-default">
				</div>
<% } %>
			</div>
			<div class="col-md-2 col-lg-2 col-xl-2 col-sm-12 col-xs-12 bg">
				<h6 id="api_resp"></h6>
			</div>
		</div> <!-- End of div / row -->


</div>
	</section>

<%@include file="jspf/footer.jspf" %>

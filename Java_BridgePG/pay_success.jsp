<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.StringTokenizer"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.api.ApiCall"%>

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
			System.out.println("step 1 pay_success is starts.. ");
			String bridgePrivateKey      = "LS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tDQpNSUlDZUFJQkFEQU5CZ2txaGtpRzl3MEJBUUVGQUFTQ0FtSXdnZ0plQWdFQUFvR0JBTXJTNFdsaDNsK3pCcmtFDQpNQ3A2MWJ1ZHlVVldrSEowVkNSM1ZmTk8zTEh1ektBazZLUHJDc0NUQjVGWURaT243L3BBdi9yM21lNGtOTEc3DQpUMlp3WWtKT0JNdnY0SVdBcU9qWGRIRGNYZDF1TG93MlNSZ29hVDlqY3JFSHdDSWVqUmI4TUlUbys1bXpIZWJDDQpkQU1wNEtMNVhQelgrUFgvc3JQdTYxZWl5MzNOQWdNQkFBRUNnWUVBaGdVc2ozN3MrdDJJUHE4bXlKc2NLZm9NDQpLZllXUXByZGtxOE1LMWJiKy9Nb1lWV2lKOVpDNTViLzlDbHo1ektjSHdlMEU3aVNqVXA5UzBmVElvUjJWOTZjDQo2Vnl3bWhiYTNXemN0UVliSmpCNzJaZ3NBRFZZRXBSb3VSOVBnSStETENKeVFBb0RnNHR1L0J6a0VaU0ZSUzNFDQpNcFlOYi9UTTZzekRualN0UVowQ1FRRG5BT2dPamd3U1cvTEdvbGdEa1Rkd2FpQ0U3L1BsNHZwYUxFLzlNTU1kDQpvd0NzbU9NN3F6SXZNRUx1dUZ0WUFyMWJ5aEFtdzBQS1pVY1FGWFowVDhqSEFrRUE0TVZibS9yVXRXR242UjR0DQo4a0pzTUxOMXY0blFyaU1HNHBzS2o1V0pvYmpnSWp5UHBxOFhwb2dLYXIra244TGxERHh1TlFIK1hBZWhQNjBYDQpEVVo0eXdKQWJDUG9mcWZRenVkc2g4Q0lJMk5mNktoR0FQV3ozL0taOEl5K0JYRkdaaUZndDJ2N05IdTRTbzcxDQpSbnZYaHlRQk1XOHVrSGJvelY4TUhXTnV5SlJ4RVFKQkFMV1QyYmk5UGo2MUFGOWJhUVN2VWhWWnRJS2lRN21aDQpSRU9sdWpkYU4xQTFPS09QeHdDQnJCcDFCZTFNbWlJUjROVXNzRjhVR0RhaVYwcEllem5YTjFjQ1FRRGpKZVZFDQo2OW1yOXJUeHBMZjdsRVFRbTZQaGl3dW5KaWRXVUp4T2tPY1dTclpqZHRuejJBUkJZdnJnclhkeGdtb0h2YmlsDQp5VzMwOGNITG53Wml6bWVmDQotLS0tLUVORCBQUklWQVRFIEtFWS0tLS0t";
			String bridgePublicKey       = "LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0NCk1JR2ZNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0R05BRENCaVFLQmdRQ3FiOVV5T204VkxZS2IyRE1lZVVPaEUvMS8NCmEyNFpwSWIxUHhqanhXNkNpMXFGRkcrVlNJekxqMlhzSHhoUXA4UEw4U3IxNmV2UnhRL2Fmb0F6Uzdia2dBU0wNCmFmRTN4Ym1DQ1JjeFZvVHRLekgzelFJK1FOeDZ3aEFaTXBwWnB1U01Ma3hFK0lFdXY1RHFOSENaZXZ4MkM4Z1kNCkxhVkVBOENPSmFuNUYxaU1nd0lEQVFBQg0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0t";
			System.out.println("step 7 pay_success is starts.. ");
			
		String enc_vals = request.getParameter("bridgeResponseMessage");
			System.out.println("step 2 enc_vals == "+enc_vals);
        bridgeutil.BridgeCryptor bg = bridgeutil.BridgeFactory.getBridgeCryptor();
			System.out.println("step 3 bg == "+bg);
        bg.setKeys(bridgePrivateKey, bridgePublicKey);

        String dec_vals = bg.decrypt(enc_vals);
			System.out.println("step 4 dec_vals == "+dec_vals);
        Map vals = new HashMap<String, Object>();
			System.out.println("step 5 vals == "+vals);
        String []t1 = {"a1", "a2", "a3"};
			System.out.println("step 6 t1 == "+t1);
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
					System.out.println("step 5 arr_enquiry_p == "+arr_enquiry_p);
String arr_status_p[] = {
							"merchant_txn",
							"csc_txn"
						};
					System.out.println("step 5 arr_status_p == "+arr_status_p);
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
api_inputs.put("merchant_date", "Merchant Date");
api_inputs.put("merchant_reciept", "Merchant Receipt");

JSONObject api_calls_json = new JSONObject(vals);
	System.out.println("step 7 api_calls_json == "+api_calls_json);
String api_calls_str = api_calls_json.toString();
	System.out.println("step 8 api_calls_str == "+api_calls_str);
Map<String, String> posted_vals = new HashMap<String, String>();
	System.out.println("step 9 posted_vals == "+posted_vals);
StringTokenizer st = new StringTokenizer(dec_vals, "|");
	System.out.println("step 10 st == "+st);
while(st.hasMoreTokens()){
    String nc = st.nextToken();
		System.out.println("step 11 nc == "+nc);
    if(nc.trim().length() <= 0 )
        continue;
    StringTokenizer st2 = new StringTokenizer(nc, "=");
		System.out.println("step 12 st2 == "+st2);
    String cKey = st2.hasMoreTokens()?st2.nextToken():"";
		System.out.println("step 13 cKey == "+cKey);
    String cVal = st2.hasMoreTokens()?st2.nextToken():"";
		System.out.println("step 14 cVal == "+cVal);
    posted_vals.put(cKey, cVal);
}

JSONObject posted_json = new JSONObject(posted_vals);
	System.out.println("step 15 posted_json == "+posted_json);
String posted_val_str = posted_json.toString();
	System.out.println("step 16 posted_val_str == "+posted_val_str);
	
	
	
%>

		<div class="row">
			<div class="col-md-8 col-lg-8 col-xl-8 col-sm-12 col-xs-12 bg">
				<h4>CSC PG Respponse</h4><hr>
<% for (Map.Entry<String, String> apiParam : api_inputs.entrySet()){
	System.out.println("Step 17 apiParam == "+apiParam);
	String api = apiParam.getKey();	
System.out.println("Step 18 api == "+api);	%>
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
<% for (Map.Entry<String, Object> entry : api_calls.entrySet()) {
	System.out.println("Step 19 entry == "+entry);
String api1 = entry.getKey();	
System.out.println("Step 20 api1 == "+api1);
	%>
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
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>
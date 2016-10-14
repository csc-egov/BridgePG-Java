<%-- 
    Document   : index
    Created on : 15 Jul, 2016, 6:11:12 PM
    Author     : sandeep
--%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="bridgeutil.BridgeCryptor"%>
<%@page import="bridgeutil.BridgeFactory"%>
<%@page import="bridgeutil.BridgePgUtil"%>
<% String pageName = "shop"; %>
<%@include file="jspf/header.jspf" %>


	<section id="inner-headline">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<ul class="breadcrumb">
					<li><a href="index.html">Home</a><i class="icon-angle-right"></i></li>
					<li class="active">Payments</li>
				</ul>
			</div>
		</div>
	</div>
	</section>
        <%
            int random_num =  (int)(Math.random() * (100000 - 10000) + 10000 );
            String transactionNo     = "MTXN" + random_num;
            String receiptNo         = "RCPT" + random_num;
            String transactionAmount = request.getParameter("amt");
            String productId         = request.getParameter("pid");
            String merchantId        = "11121";

            String url = request.getRequestURL().toString();
            String baseURL = url.substring(0, url.length() - request.getRequestURI().length()) + request.getContextPath() + "/";
            
            BridgePgUtil bg = new BridgePgUtil();
            bg.createBridgeDefaultParameters();
            bg.addParameter("merchant_id", merchantId);
            bg.addParameter("csc_id", username);
            bg.addParameter("product_id", productId);
            bg.addParameter("txn_amount", transactionAmount);
            bg.addParameter("merchant_txn", transactionNo);
            bg.addParameter("merchant_receipt_no", receiptNo);
            bg.addParameter("return_url", baseURL + "pay_success.jsp");
            bg.addParameter("cancel_url", baseURL + "pay_success.jsp");
            
            String encText = bg.getEncryptedParameters(bridgePrivateKey, bridgePublicKey);
            String urlFraction = bg.getUrlFraction();
        %>

	<!-- payment response section  -->
	<section id="content">
	<div class="container">
		<div class="row">
			<div class="col-lg-6">
				<h1>Proceed To Pay</h1>
				<h4>Invoice#: <%= receiptNo %></h4>
				<h4>txn ID :  <%= transactionNo %></h4>
				<h3>Amount: <%= transactionAmount %> </h3>
				<form method="post" action="<%= bridgePayAddress + urlFraction %>" >
                                    <input type="hidden" name="message" value="<%= merchantId + "|" + encText %>" />
                                    <input type="submit" value="Pay" />
				</form>
			</div>
			<div class="col-lg-6">
				<h4>Product Details</h4>
				<p>
					<strong>Information</strong>, write a summary of transaction for VLE to see
				</p>
				
				
		</div>
	
		
		
		<!-- divider -->
		<div class="row">
			<div class="col-lg-12">
				<div class="solidline">
				</div>
			</div>
		</div>

		<!-- end divider -->
		<div class="row">
			<div class="col-lg-12">
				<h4>Wait for Response from CSC Payment Gateway</h4>

			</div>
		</div>
	</div>
	</section>

<%@include file="jspf/footer.jspf" %>

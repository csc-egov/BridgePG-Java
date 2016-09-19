# BridgePG-Java
CSC Bridge PG Integration Kit in Java

Instructions:
*. Reset your password by using the link you have recieved via email.
*. Supported JRE platforms are JRE 1.7+. Please also make sure that Java installation has unlimited strength jurisdiction policy of Java Cryptography Extension (JCE) installed.
*. Login to Merchant Center Portal: "portal.csccloud.in" and follow the below steps:

      Generate Connect Config. File
        1.Click on “CSC Connect”.
        2.Provide the Application Name, Call Back Url and upload the application logo and click on save button to add the application.
        3.Generate your Client ID by clicking on "Generate Client Id" button.
        4.Generate your Client Secret and Client Token.
        5.Click on save button to generate your Connect Config. File.
        6.Download the Connect Config. File.
        
     Generate Bridge Config. File
        1.Click on "CSC Bridge".
        2.Select "Key Manager" option.
        2.Generate keys by clicking on to the “Generate Keys” button.
        3.Download the Bridge Config. File.

Use these configuration file into your code.

The illustrated code sample below provides the understanding of using the java integration kit.

Step 1	Create an encrypted payment request as in example file. (payment.jsp)

<%
            int random_num =  (int)(Math.random() * (100000 - 10000) + 10000 );
            String transactionNo     = "MTXN" + random_num;
            String receiptNo         = "RCPT" + random_num;
            String transactionAmount = request.getParameter("amt");
            String merchantId        = "11121";

            String url = request.getRequestURL().toString();
            String baseURL = url.substring(0, url.length() - request.getRequestURI().length()) + request.getContextPath() + "/";
            
            BridgePgUtil bg = new BridgePgUtil();
            bg.createBridgeDefaultParameters();
            bg.addParameter("merchant_id", merchantId);
            bg.addParameter("csc_id", username);
            bg.addParameter("txn_amount", transactionAmount);
            bg.addParameter("merchant_txn", transactionNo);
            bg.addParameter("merchant_receipt_no", receiptNo);
            bg.addParameter("return_url", baseURL + "pay_success.jsp");
            bg.addParameter("cancel_url", baseURL + "pay_success.jsp");
            
            String encText = bg.getEncryptedParameters(bridgePrivateKey, bridgePublicKey);
            String urlFraction = bg.getUrlFraction();

...

<form method="post" action="<%= bridgePayAddress + urlFraction %>" >
     <input type="hidden" name="message" value="<%= merchantId + "|" + encText %>" />
     <input type="submit" value="Pay" />
</form>


Following is the wrapper for accessing bridge. (BridgePGUtil.jsp)

    class BridgePGUtil{
        private HashMap<String, String> parameters;
        
        public BridgePGUtil(){
            this.parameters = new HashMap<String, String>();
        }

        public Map<String, String> getBridgeDefaultParameters(){
            return this.parameters;
        }

        public boolean addParameter(String key, String value){
            parameters.put(key, value);
            return true;
        }
        
        public String getParameterString(){
            String ret = "";
            for (Map.Entry<String, String> entry : parameters.entrySet()) {
                ret +=  entry.getKey().trim() + "=" + entry.getValue().trim() + "|";
            }
            return ret;
        }
        
        public String getEncryptedParameters(String bridgePrivateKey,String bridgePublicKey){
            BridgeCryptor bc  = BridgeFactory.getBridgeCryptor();
            bc.setKeys(bridgePrivateKey, bridgePublicKey);
            return bc.encrypt(getParameterString());
        }
        
        public String getUrlFraction(){
            SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
            String date_str = sdf.format(new Date()).toString();
            long date_str_long = Long.parseLong(date_str);
            
            return date_str_long * 883 + (1000 - 883) + "";
        }

        public Map<String, String> createBridgeDefaultParameters(){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String date_str = sdf.format(new Date()).toString();
            int rand =  (int)(Math.random() * (100000 - 10000) + 10000 );
            parameters.put("merchant_id"           ,  "11121"               );
            parameters.put("merchant_txn"          ,  "M" + rand            );
            parameters.put("merchant_txn_date_time",  date_str              );
            parameters.put("product_id"            ,  "1112101"             );
            parameters.put("product_name"          ,  "my product"          );
            parameters.put("txn_amount"            ,  "100"                 );
            parameters.put("amount_parameter"      ,  "NA"                  );
            parameters.put("txn_mode"              ,  "D"                   );
            parameters.put("txn_type"              ,  "D"                   );
            parameters.put("merchant_receipt_no"   ,  "RCPT" + rand         );
            parameters.put("csc_share_amount"      ,  "0"                   );
            parameters.put("pay_to_email"          ,  "na"                  );
            parameters.put("return_url"            ,  "na"                  );
            parameters.put("cancel_url"            ,  "na"                  );
            parameters.put("Currency"              ,  "INR"                 );
            parameters.put("Discount"              ,  "0"                   );
            parameters.put("param_1"               ,  "NA"                  );
            parameters.put("param_2"               ,  "NA"                  );
            parameters.put("param_3"               ,  "NA"                  );
            parameters.put("param_4"               ,  "NA"                  );

            return this.parameters;
        }
    }

Step 2	Process pay response to get status of payment as in sample file. (payment_response.jsp)


<%
 String enc_vals = request.getParameter("bridgeResponseMessage");
 bridgeutil.BridgeCryptor bg = bridgeutil.BridgeFactory.getBridgeCryptor();

 bg.setKeys(bridgePrivateKey, bridgePublicKey);

 String dec_vals = bg.decrypt(enc_vals);
 %>




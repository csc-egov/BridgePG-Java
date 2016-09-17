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

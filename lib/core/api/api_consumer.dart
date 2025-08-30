abstract class ApiConsumer {

  Future<Map<String,dynamic>> get (String endPoint,{Object data ,Map<String,dynamic> queryParm, bool formData=false});

  Future<Map<String,dynamic>> post(String endPoint,{dynamic data ,Map<String,dynamic> queryParm,bool formData=false});

  Future<Map<String,dynamic>> patch(String endPoint,{Object data ,Map<String,dynamic> queryParm,bool formData=false});

  Future<Map<String,dynamic>> delete(String endPoint,{Object data ,Map<String,dynamic> queryParm,bool formData=false});

}
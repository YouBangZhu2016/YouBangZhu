<?php
namespace Home\Controller;
use Think\Controller;
class UserController extends Controller {

    public function getUserInfo(){
        $result = array('user_phone' => '',
        	'user_email' => '',
            'account_state' => '',
            'msg' =>'');
        $user_info_table = M('user_saftyinfo');
        $condition['user_id'] = I('user_id'); 
        $data = $user_info_table->where($condition)->find();
        if ($data !== false) {
            $result['user_phone'] = $data['user_phone'];
            $result['user_email'] = $data['user_email'];
            $result['account_state'] = $data['account_state'];
            $result['msg'] = '';
        } else {
            //数据库内部错误
            $result['msg'] = '操作失败';
        }
        echo(json_encode($result));
    }

    public function edit()
    {
        $user_id = I('user_id');
        $result = array('state'=> '', 
            'msg' => '',
            'user_info' =>'');
         $user_detailedinfo_table = M('user_detailedinfo');
         $conditon['user_id'] = $user_id;
         $data = $user_detailedinfo_table->where($conditon)->find();

         if($data !== false){
            if ($data !== null) {
                    //查询成功
                    $result['state'] = 'Success';
                    $result['msg'] = '';
                    $result['user_info']['user_photo'] = $data['user_photo'];
                    $result['user_info']['user_nickname'] = $data['user_nickname'];
                    $result['user_info']['user_sex'] = $data['user_sex'];
                    $result['user_info']['user_birth'] = $data['user_birth'];
                    $result['user_info']['user_district'] = $data['user_district'];
                    $result['user_info']['user_signature'] = $data['user_signature'];   
            }
            else{
                //用户没有注册
                $result['state'] = 'Failure';
                $result['msg'] = 'User have not registued';
            }
         }
         else{
            //数据库内部错误
            $result['state'] = 'Failure';
            $result['msg'] = 'have not fond';
         }
         echo (json_encode($result));

    }
    public function upload()
    {
        $newUser['user_id'] = I('newuser_id');
        $newUser['user_photo'] = I('newuser_photo');
        $newUser['user_nickname']   = I('newuser_nickname');
        $newUser['user_sex']   = I('newuser_sex');
        $newUser['user_birth']   = I('newuser_birth');
        $newUser['user_district']   = I('newuser_district');
        $newUser['user_signature']   = I('newuser_signature');
        $user_detailedinfo_table = M('user_detailedinfo');
        $user_info_table = M('user_info');
        $userName['user_name']=$newUser['user_nickname'];
        $result = array('state'=> '', 
            'msg' => '');

        $conditon['user_id'] = I('newuser_id');
        $data = $user_detailedinfo_table->where($conditon)->find();

        if ($conditon !== null) {
            if ($data !== null) {
                //用户已编辑信息
                $user_detailedinfo_table -> save($newUser);
                $result['state'] = 'Success';
                $result['msg'] = 'User have edited  !!!';
                
                $user_info_table->where($conditon)->setfield($userName);
            }
            else{
                //用户未编辑信息
                $user_detailedinfo_table -> add($newUser);
                $result['state'] = 'Success';
                $result['msg'] = 'User have not edited !!!';
            }
        }else{
            //用户未注册
            $result['state'] = 'Failure';
            $result['msg'] = 'Not have the User !!!';       
        }
        
        echo (json_encode($result));
    }
    //下拉登录状态
    public function userloginstate(){
         $user_id = I('user_id');
        $result = array('state'=>'',
            'msg'=>'',
             'data');
        $user_info_table = M('user_info');
        $conditon['user_id'] = $user_id;
        $data = $user_info_table->where($conditon)->find();
        $result['state'] = $data['user_loginstate'];
        echo (json_encode($result));
    }

    public function login(){
        $user_id = I('user_id');
        $user_phone = I('user_phone');
        $user_password =  I('user_password');
        $user_loginstate = I('user_loginstate');
        $result = array('state'=>'',
            'msg'=>'',
             'data');
        $user_info_table = M('user_info');
        $conditon['user_phone'] = $user_phone;
        $data = $user_info_table->where($conditon)->find();
        if ($data !==false) {
            if ($data !== null) {
                # code...
                if ($user_password !==$data['user_password']) {
                    //密码错误
                      $result['user_info']['user_phone'] = $data['user_phone'];
                      $result['state'] = 'Failure';
                      $result['msg'] = 'Wrong PassWord1';
                }else{
                    //验证成功
                    $result['state'] = 'Success';
                    $result['msg'] = '';
                    $result['user_info']['user_id'] = $data['user_id'];
                    $result['user_info']['user_loginstate'] = $data['user_loginstate'];
                    $result['user_info']['user_phone'] = $data['user_phone'];
                    $result['user_info']['user_password'] = $data['user_password'];

                    $find['user_loginstate']= '1';
                   $user_info_table->where($conditon)->setfield($find);
                }
            }else{
                //用户没有注册
               $result['state'] = 'Failure';
               $result['msg'] = 'you have not register';
            }
        }else{
            //数据库内部错误
            $result['state'] = 'Failure';
            $result['msg'] = 'shujuku';
        }
        echo (json_encode($result));
    }
    public function user_register(){
        $user_id = I('user_id');
        $user_phone = I('user_phone');
        $user_password =  I('user_password');
        $user_name = I('user_name');
        $result = array('state'=>'',
            'msg'=>'',
            'data');
                //添加
        $user_info_table = M('user_info');
        $user_detailedinfo_table = M('user_detailedinfo');
        $user_saftyinfo_table =M('user_saftyinfo');
        $insert['user_id']=$user_id;
        $insert['user_phone']=$user_phone;
        $insert['user_password']=$user_password;
        $insert['user_name']=$user_name; 
        
        $userinfo['user_id']=$user_id;
        $userinfo['user_nickname']=$user_name;

        $saftyinfo['user_id']=$user_id;
        $saftyinfo['user_phone']=$user_phone;

        if($result!==null){
            //Success
            $result=$user_info_table->add($insert);
            $result=$user_detailedinfo_table->add($userinfo);
            $result=$user_saftyinfo_table->add($saftyinfo);
           $result['state'] = 'Success';

        }else{
           $result['state'] = 'Failure';
            //Failure
        }
        echo (json_encode($result));

    }
    public function user_findKey(){
        $user_id = I('user_id'); 
        $user_phone = I('user_phone');
        $user_password =  I('user_password');
        $result = array('state'=>'',
            'msg'=>'',
             'data');
        //更改
        $user_info_table = M('user_info');
        $conditon['user_id'] = $user_id;
        $find['user_phone']=$user_phone;
        $find['user_password']=$user_password;

        $data = $user_info_table->where($conditon)->setfield($find);
    }

    public function evaluate(){
        $translator_id = I('translator_id');
        $valuator_id = I('valuator_id');
        $evaluate_infostar = I('evaluate_infostar');
        $evaluate_infotext = I('evaluate_infotext');
        $evaluate_time = I('evaluate_time');

        $translator_evaluateinfo = M('translator_evaluateinfo');

        $evaluate_info['translator_id'] = $translator_id;
        $evaluate_info['valuator_id'] = $valuator_id;
        $evaluate_info['evaluate_infostar'] = $evaluate_infostar;
        $evaluate_info['evaluate_infotext'] = $evaluate_infotext;
        $evaluate_info['evaluate_time'] = $evaluate_time;
        
        $translator_evaluateinfo -> add($evaluate_info);
    }

    public function loginProtocol()
    {
        $version_num = I('version_num');

        $result = array('state'=> '', 
            'msg' => '',
            'official_send' =>'');

         $official_send_table = M('official_send');
         $conditon['version_num'] = $version_num;
         $data = $official_send_table->where($conditon)->find();

         if($data !== false){
            if ($data !== null) {
                //成功
                $result['state'] = 'Success';
                $result['msg'] = '';
                $result['official_send']['protocol_text'] = $data['protocol_text'];    
            }
            else{
                //版本没有更新
                $result['state'] = 'Failure';
                $result['msg'] = 'not update';
            }
         }
         else{
            //数据库内部错误
            $result['state'] = 'Failure';
            $result['msg'] = 'have not fond';
         }
         echo (json_encode($result));
    }
    public function loginHelp(){
        $user_id = I('user_id');
        $user_feedbackinfo = I('user_feedbackinfo');
        $feedbackinfo_time = I('feedbackinfo_time');
        $user_phone = I('user_phone');
        $user_email = I('user_email');
        $help_feedback_table = M('help_feedback');
        $newhelp_feedback['user_id'] = $user_id;
        $newhelp_feedback['user_feedbackinfo'] = $user_feedbackinfo;
        $newhelp_feedback['feedbackinfo_time'] = $feedbackinfo_time;
        $newhelp_feedback['user_phone'] = $user_phone;
        $newhelp_feedback['user_email'] = $user_email;
        $help_feedback_table -> add($newhelp_feedback);
        $result = array('state'=> '', 
            'msg' => '',
            'official_send' =>'');
        
         $conditon['user_id'] = $user_id;
         $data = $help_feedback_table->where($conditon)->find();

         if($data !== false){
            if ($data !== null) {
                //成功
                $result['state'] = 'Success';
                $result['msg'] = '';
                $result['official_send'] = $data;   
            }
            else{
                //版本没有更新
                $result['state'] = 'Failure';
                $result['msg'] = 'not insert';
            }
         }
         else{
            //数据库内部错误
            $result['state'] = 'Failure';
            $result['msg'] = 'have not fond';
         }
         echo (json_encode($result));
     }
     public function loginAbout(){
        $version_num = I('version_num');
        $result = array('state'=> '', 
            'msg' => '',
            'official_send' =>'');
         $official_send_table = M('official_send');
         $conditon['version_num'] = $version_num;
         $data = $official_send_table->where($conditon)->find();

         if($data !== false){
            if ($data !== null) {
                //成功
                $result['state'] = 'Success';
                $result['msg'] = '';
                $result['official_send']['about-text'] = $data['about-text'];
            }
            else{
                //版本没有更新
                $result['state'] = 'Failure';
                $result['msg'] = 'not update';
            }
         }
         else{
            //数据库内部错误
            $result['state'] = 'Failure';
            $result['msg'] = 'have not fond';
         }
         echo (json_encode($result));
    }
           function Get($url)
    {

        if (function_exists('file_get_contents')) {
            // var_dump($url);
            // echo "exist"; exit();
            $file_contents = file_get_contents($url);

        }else{
            // echo "not exist"; exit();
            $ch = curl_init();
            $timeout = 5;
            curl_setopt ($ch, CURLOPT_URL, $url);
            curl_setopt ($ch, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt ($ch, CURLOPT_CONNECTTIMEOUT, $timeout);
            $file_contents = curl_exec($ch);
            curl_close($ch);

        }

        return $file_contents;

    }
 public function getValidateAndFamilyPhoneInfo()
    {
            

            $result = array();
                // $numbers = range (1000,9999); 
                // shuffle ($numbers); 
                // $num=1; 
                // $code = array_slice($numbers,0,$num); 
                 $code = rand(1000,9999);
                 // $code = "8888";
                $uid = C('SMS_UID');
                $key = C('SMS_KEY');
                $smsText = "一次性验证码：".$code.",嘱咐不要告诉别人哟！";
                $url = "http://utf8.sms.webchinese.cn/?Uid='tcsq'&Key='7a4d468e5e3255859456'&smsMob='15122463580'&smsText='啦啦啦'";
            

    
                   self::Get($url); 
                 $result['code'] =$code;
                        //////////////////
                echo (json_encode($result));
             
    }

// 'SMS_UID'               =>  'tcsq',     //短信用户名
//     'SMS_KEY'               =>  '7a4d468e5e3255859456',
public function selectLanguage()
    {
        $language_kind = I('language_kind');
        $result = array('state' => '',
        'msg' => '',
        'language' => '');

        $select_language_table = M('select_language');
        $condition['language_kind'] = $language_kind;
        $data = $select_language_table->where($condition)->find();

        if ($data !== false) {
            if ($data !== null) {
                //验证成功
            $result['state'] = 'Success';
            $result['msg'] = '';
            $result['language']['language_kind'] = $data['language_kind'];
            $result['language']['chinese_picture'] = $data['chinese_picture'];
            $result['language']['translatekind_picture'] = $data['translatekind_picture'];
            $result['language']['background_picture'] = $data['background_picture'];
            }
            else{
                //没有该语言、图片
            $result['state'] = 'Failure';
            $result['msg'] = "Don't match the language. ";
            $result['language']['language_kind'] = $data['language_kind'];
            $result['language']['chinese_picture'] = $data['chinese_picture'];
            $result['language']['translatekind_picture'] = $data['translatekind_picture'];
            $result['language']['background_picture'] = $data['background_picture'];
            }
        }
        else{
            //数据库内部错误
            $result['state'] = 'Failure';
            $result['msg'] = '数据库查询出现错误';
        }
        echo (json_encode($result));
    }


    public function addScrollViewImage()
    {

        $result = array('state' => '',
        'msg' => '',
        'image_info' => '');
        $turnpicture_id = I('turnpicture_id');

        $translatesend_info_table = M('translatesend_info');
        $condition['turnpicture_id'] = $turnpicture_id;
        $data = $translatesend_info_table->where($condition)->find();
        if ($data !== false) {
            if ($data !== null) {
                //验证成功
            $result['state'] = 'Success';
            $result['msg'] = '';
            $result['image_info']['turn_infolink'] = $data['turn_infolink'];
            }
            else{
                //没有该图片
            $result['state'] = 'Failure';
            $result['msg'] = "Don't match the image.";
            }
        }
        else{
            //数据库内部错误
            $result['state'] = 'Failure';
            $result['msg'] = '数据库查询出现错误';
        }
        echo (json_encode($result));
    }

    public function loginState(){
        $user_id = I("user_id");
        $user_saftyinfo_table = M('user_saftyinfo');
        $conditon['user_id'] = $user_id;
        $data = $user_saftyinfo_table->where($condition)->find();
    
        echo $data['account_state'];
    }

    public function user_logout(){
        $user_id = I('user_id'); 
        //更改
        $user_info_table = M('user_info');
        $user_saftyinfo_table = M('user_saftyinfo');
        $conditon['user_id'] = $user_id;
        $find['user_loginstate'] = '0';
        
        $user_info_table->where($conditon)->setfield($find);
        $user_saftyinfo_table->where($conditon)->setfield($find);
    }

    public function changeEmail(){
        $user_id = I('user_id');
        $user_email = I('user_email'); 
        $emailState = I('emailState');
        //更改ßß
        $user_info_table = M('user_saftyinfo');
        $conditon['user_id'] = $user_id;
        $find['user_email'] = $user_email;
        $user_info_table->where($conditon)->setfield($find);
        $data = $user_info_table->where($condition)->find();

        if ($data !== false) {
        
                //账号已保护
                $find['account_state']= I('emailState');
                $user_info_table->where($conditon)->setfield($find);
         
            }
         else {
            //数据库内部错误
        }
    }
    
}
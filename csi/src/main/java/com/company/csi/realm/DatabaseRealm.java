package com.company.csi.realm;

import com.company.csi.pojo.User;
import com.company.csi.service.PermissionService;
import com.company.csi.service.RoleService;
import com.company.csi.service.UserService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Iterator;
import java.util.Set;

public class DatabaseRealm extends AuthorizingRealm {

    @Autowired
    UserService userService;

    @Autowired
    PermissionService permissionService;

    @Autowired
    RoleService roleService;

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
//        //能进入到这里，表示账号已经通过验证了
//        String userName = (String) principalCollection.getPrimaryPrincipal();
//        //通过service获取角色和权限
//        Set<String> permissions = permissionService.listPermissionNames(userName);
//        Set<String> roles = roleService.listRoleNames(userName);
//
//        Iterator<String> iterator = permissions.iterator();
//        while (iterator.hasNext()) {
//            System.out.println("该用户有: " + iterator.next().toString() + " 权限");
//        }
//        Iterator<String> iterator1 = roles.iterator();
//        while (iterator1.hasNext()) {
//            System.out.println("该用户有: " + iterator1.next() + " 角色");
//        }
//
//        //授权对象
//        SimpleAuthorizationInfo s = new SimpleAuthorizationInfo();
//        //把通过service获取到的角色和权限放进去
//        s.setStringPermissions(permissions);
//        s.setRoles(roles);
//        return s;
        return null;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token)
            throws AuthenticationException {
        //获取账号密码
        UsernamePasswordToken t = (UsernamePasswordToken) token;
        String userName = token.getPrincipal().toString();
        System.out.println("输入的账号: " + userName);
        String password = new String(t.getPassword());
        System.out.println("输入的密码: " + password);
        //获取用户，获取盐，加密输入的密码
        User user = userService.getByUserName(userName);
        String salt = user.getSalt();
        String passwordEncoded = new SimpleHash("md5", password, salt, 2).toString();

        //获取数据库中的密码
        String passwordInDB = user.getUserPassword();
        //如果为空就是账号不存在，如果不相同就是密码错误
        if (null == passwordInDB || !passwordInDB.equals(passwordEncoded))
            throw new AuthenticationException();

        //认证信息里存放账号密码, getName() 是当前Realm的继承方法,通常返回当前类名 :databaseRealm
        return new SimpleAuthenticationInfo(userName, password, getName());
    }
}

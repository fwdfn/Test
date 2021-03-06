﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductTypeManager.aspx.cs" Inherits="艾维斯特.background.ProductFile.ProductTypeManager" %>
<%@ Register Assembly="FredCK.FCKeditorV2" Namespace="FredCK.FCKeditorV2" TagPrefix="FCKeditorV2" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../css/bg_index_css.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-1.10.2.min.js"></script>
    <script type="text/javascript">
        $(function () {
            
            $("#gv table tr td").first().attr("width", "80%");
            $("#iframe", window.parent.parent.document).height($("body").height());
            $("#bodyTopLeft").height($("#bodyTop").height());
            $("#bodyTopRight").height($("#bodyTop").height());
        })

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="title">    
            <img src="../images/bg_index_right_topBg2.jpg" class="bgLeft" />
            <img src="../images/bg_index_right_topBg3.jpg" class="bgRight" />
        </div>
        <div id="bodyTop">
            <div id="bodyTopLeft"></div>
            <div id="bodyTopRight"></div>                          
              <div class="Title">
                <span class="TitleName"><%=columnInfo %></span>
              </div>
              <table id="EditColumnTable" cellspacing="1px">
                     <tr>
                         <td class="editColumnLeft" >栏目名称：</td>
                         <td class="editColumnRight" ><input type="text" id="name" runat="server" /></td>
                     </tr>
                     <tr>
                         <td class="editColumnLeft">所属栏目：</td>
                         <td class="editColumnRight">
                             <asp:DropDownList ID="ddlType" runat="server">                                 
                             </asp:DropDownList>
                             <span style="color:red" >*当不选择一级栏目时则修改一级栏目</span>
                         </td>
                     </tr>        
                     <tr>
                         <td class="editColumnLeft">序号：</td>
                         <td class="editColumnRight"><input type="text" id="EditColumnRightsort" runat="server" /></td>
                     </tr>        
                     <tr>
                         <td class="editColumnLeft">是否隐藏：</td>
                         <td class="editColumnRight">
                             是：<input type="radio" id="Hide" runat="server" name="isHide" />
                             否：<input type="radio" id="Show" runat="server" checked=true  name="isHide" />
                         </td>
                     </tr>                                       
                    <tr>
                        <td class="editColumnLeft">备注：</td>
                        <td class="editColumnRight">
                            <FCKeditorV2:FCKeditor ID="txtContent" runat="server" Width="650" Height="400"></FCKeditorV2:FCKeditor>
                        </td>
                    </tr>
                     <tr>
                         <td colspan="2" style="border-right:0;" >
                             <input type="button" id="submitBtn" runat="server" value="提交" class="btnBG" onserverclick="submitBtn_ServerClick" />
                             <input type="button" id="cancelBtn" runat="server" value="取消" class="btnBG"  />
                         </td>
                     </tr>               
                </table>                              
        </div>
        <div id="bodyBottom">
            <img src="../images/ifrBottom_bg2.jpg" class="bgLeft"  />
            <img src="../images/ifrBottom_bg3.jpg" class="bgRight" />
        </div>
    </form>
</body>
</html>

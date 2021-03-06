<%--升级项组件--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<template id="upgradeItemTmpl">
    <div class="panel-group table-responsive">
        <div class="panel-group table-responsive panel panel-default" style="padding:0px 15px">
            <div class="row panel panel-heading" style="padding: 10px">
                <div class="col-sm-2" style="text-align: left">
                    <h4>升级项 ({{skuSum}})</h4>
                </div>
                <div class="col-sm-10" style="text-align: right" v-if="(pageType == 'select' || pageType == 'change') && catalogUrl != 'other'">
                    <button type="button" class="btn btn-primary" @click="addProdModel()">
                        添加
                    </button>
                </div>
            </div>
            <div class="row panel-body">
                <table width="100%" class="table table-striped table-bordered table-hover
                    table-de panel-heading border-bottom-style" style="margin-top: 10px">
                    <thead>
                    <%--遍历二级分类 并且当二级分类下面有sku数据时,展示--%>
                        <tr align="center" v-for="catalog in lowerCatalogList"
                            v-show="catalog.projectMaterialList != null && catalog.projectMaterialList.length > 0">
                            <td width="10%" style="vertical-align: middle; text-align: center">
                                {{catalog.parent.name}} <br>
                                {{catalog.name}} <br>
                            </td>
                            <td width="90%">

                                <%--大类目明细--%>
                                <div class="table-bd" v-for="projectMaterial in catalog.projectMaterialList" >
                                    <%--选材!--%>
                                    <div v-if="!projectMaterial.backColorFlag" >
                                        <!--商品projectMaterial属性-->
                                        <div class="table-row clearfix" >
                                            <div class="item item-proname clearfix">
                                                <img class="goods-media pull-left" :src="projectMaterial.skuImagePath" alt="商品图" width="80" height="80" />
                                                <div class="item-inner pull-left">
                                                    <div class="goods-title _ellipsis" >
                                                        {{projectMaterial.productName}}
                                                    </div>
                                                    <div class="goods-item _ellipsis4">
                                                        属性: {{projectMaterial.attribute1}}<br>
                                                        属性: {{projectMaterial.attribute2}}<br>
                                                        属性: {{projectMaterial.attribute3}}<br>
                                                        规格: {{projectMaterial.skuSqec}}
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="item item-pay">
                                                <p>
                                                    <input type="text" class="input-num" v-model="projectMaterial.lossDosageAmount" readonly>
                                                    <%--当平米转片时,单位显示为 片--%>
                                                    <span v-if="projectMaterial.skuDosageList[0].convertUnit == 'square_meter_turn'">
                                                        片
                                                    </span>
                                                    <span v-else>
                                                        {{projectMaterial.materialUnit.substring(projectMaterial.materialUnit.indexOf("/")+1, projectMaterial.materialUnit.length)}}
                                                    </span>
                                                </p>
                                                <p>单 价：￥ {{projectMaterial.storeSalePrice}}&nbsp;
                                                    <%--当平米转片时,单位显示为 元/片--%>
                                                    <span v-if="projectMaterial.skuDosageList[0].convertUnit == 'square_meter_turn'">
                                                        元/片
                                                    </span>
                                                    <span v-else>
                                                        {{projectMaterial.materialUnit}}
                                                    </span>
                                                </p>
                                                <p>合 计：<span class="text-red">￥ {{projectMaterial.skuSumMoney}}</span></p>
                                            </div>
                                            <div class="item item-operation">
                                                <p v-if="pageType == 'select' || pageType == 'change'">
                                                    <a class="links" href="javascript:;" @click="addSkuDosageModel(catalog, projectMaterial)">添加用量</a>
                                                </p>
                                                <p>
                                                    <span v-if="pageType == 'select' || pageType == 'change'">
                                                        <a class="links" href="javascript:;" @click="updateRemark('设计备注', projectMaterial)">设计备注</a>
                                                    </span>
                                                    <span v-if="pageType == 'audit'">
                                                        <a class="links" href="javascript:;" @click="updateRemark('审计备注', projectMaterial)">审计备注</a>
                                                    </span>
                                                </p>
                                                <p v-if="pageType == 'select'">
                                                    <a class="links" href="javascript:;"
                                                       @click="removeSku(catalog.projectMaterialList, projectMaterial)">
                                                        移&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;除
                                                    </a>
                                                </p>
                                            </div>
                                        </div>
                                        <%--用量集合 dosageList--%>
                                        <!-- /.table-row -->
                                        <div class="table-row clearfix" v-for="skuDosage in projectMaterial.skuDosageList">
                                            <div class="item item-proname" v-if="skuDosage.lossDosage != 0">
                                                <div class="item-inner">
                                                    <div class="goods-item clearfix">
                                                        <span>功能区：{{skuDosage.domainName}}</span>
                                                        <%--<span>损耗系数：{{skuDosage.lossFactor}}</span>--%>
                                                        <span>预算用量：{{skuDosage.budgetDosage}}&nbsp;
                                                            <%--当平米转片时,单位显示为㎡--%>
                                                            <span v-if="skuDosage.convertUnit == 'square_meter_turn'">
                                                                ㎡
                                                            </span>
                                                            <span v-else>
                                                                {{projectMaterial.materialUnit.substring(projectMaterial.materialUnit.indexOf("/")+1, projectMaterial.materialUnit.length)}}
                                                            </span>
                                                        </span>
                                                        <span>含损耗用量：{{skuDosage.lossDosage}}&nbsp;
                                                            <%--当平米转片时,单位显示为片--%>
                                                            <span v-if="skuDosage.convertUnit == 'square_meter_turn'">
                                                                片
                                                            </span>
                                                            <span v-else>
                                                                {{projectMaterial.materialUnit.substring(projectMaterial.materialUnit.indexOf("/")+1, projectMaterial.materialUnit.length)}}
                                                            </span>
                                                        </span>
                                                        <span>用量备注：<font color="#008b8b">{{skuDosage.dosageRemark}}</font> </span>
                                                        <a href="#" class="pull-right" v-if="pageType == 'select' || pageType == 'change'"
                                                           @click="removeSkuDosage(projectMaterial, projectMaterial.skuDosageList, skuDosage)">删除
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /.table-row -->
                                        <div class="table-row clearfix">
                                            <div class="item item-proname">
                                                <div class="item-inner">
                                                    <div class="goods-item">
                                                        <span>预算用量合计：{{projectMaterial.budgetDosageAmount}}&nbsp;
                                                            <%--当平米转片时,单位显示为㎡--%>
                                                            <span v-if="projectMaterial.skuDosageList[0].convertUnit == 'square_meter_turn'">
                                                                ㎡
                                                            </span>
                                                            <span v-else>
                                                                {{projectMaterial.materialUnit.substring(projectMaterial.materialUnit.indexOf("/")+1, projectMaterial.materialUnit.length)}}
                                                            </span>
                                                        </span>
                                                        <span>含损耗用量合计：{{projectMaterial.lossDosageAmount}}&nbsp;
                                                            <%--当平米转片时,单位显示为片--%>
                                                            <span v-if="projectMaterial.skuDosageList[0].convertUnit == 'square_meter_turn'">
                                                                片
                                                            </span>
                                                            <span v-else>
                                                                {{projectMaterial.materialUnit.substring(projectMaterial.materialUnit.indexOf("/")+1, projectMaterial.materialUnit.length)}}
                                                            </span>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /.table-row -->
                                        <div class="table-row clearfix">
                                            <div class="item item-proname">
                                                <div class="item-inner">
                                                    <div class="goods-item"><span>设计备注：<span style="color:#ff9900">{{projectMaterial.designRemark}}</span> </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /.table-row -->
                                        <div class="table-row clearfix">
                                            <div class="item item-proname">
                                                <div class="item-inner">
                                                    <div class="goods-item"><span>审计备注：<span style="color:#FF3030">{{projectMaterial.auditRemark}}</span></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /.table-row -->
                                    </div>

                                    <%--变更!--%>
                                    <div v-if="projectMaterial.backColorFlag == 'change'" :class="backColorObj.changeBackColor">
                                        <!--商品projectMaterial属性-->
                                        <div class="table-row clearfix" >
                                            <div class="item item-proname clearfix">
                                                <img class="goods-media pull-left" :src="projectMaterial.skuImagePath" alt="商品图" width="80" height="80" />
                                                <div class="item-inner pull-left">
                                                    <div class="goods-title _ellipsis" >
                                                        {{projectMaterial.productName}}
                                                    </div>
                                                    <div class="goods-item _ellipsis4">
                                                        属性: {{projectMaterial.attribute1}}<br>
                                                        属性: {{projectMaterial.attribute2}}<br>
                                                        属性: {{projectMaterial.attribute3}}<br>
                                                        规格: {{projectMaterial.skuSqec}}
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="item item-pay">
                                                <p>
                                                    <input type="text" class="input-num" v-model="projectMaterial.lossDosageAmount" readonly>
                                                    <%--当平米转片时,单位显示为 片--%>
                                                    <span v-if="projectMaterial.skuDosageList[0].convertUnit == 'square_meter_turn'">
                                                        片
                                                    </span>
                                                    <span v-else>
                                                        {{projectMaterial.materialUnit.substring(projectMaterial.materialUnit.indexOf("/")+1, projectMaterial.materialUnit.length)}}
                                                    </span>
                                                </p>
                                                <p>单 价：￥ {{projectMaterial.storeSalePrice}}&nbsp;
                                                    <%--当平米转片时,单位显示为 元/片--%>
                                                    <span v-if="projectMaterial.skuDosageList[0].convertUnit == 'square_meter_turn'">
                                                        元/片
                                                    </span>
                                                    <span v-else>
                                                        {{projectMaterial.materialUnit}}
                                                    </span>
                                                </p>
                                                <p>合 计：<span class="text-red">￥ {{projectMaterial.skuSumMoney}}</span></p>
                                            </div>
                                            <div class="item item-operation">
                                                <p v-if="pageType == 'select' || pageType == 'change'">
                                                    <a class="links" href="javascript:;" @click="addSkuDosageModel(catalog, projectMaterial)">添加用量</a>
                                                </p>
                                                <p>
                                                    <span v-if="pageType == 'select' || pageType == 'change'">
                                                        <a class="links" href="javascript:;" @click="updateRemark('设计备注', projectMaterial)">设计备注</a>
                                                    </span>
                                                    <span v-if="pageType == 'audit'">
                                                        <a class="links" href="javascript:;" @click="updateRemark('审计备注', projectMaterial)">审计备注</a>
                                                    </span>
                                                </p>
                                                <p v-if="pageType == 'select'">
                                                    <a class="links" href="javascript:;"
                                                       @click="removeSku(catalog.projectMaterialList, projectMaterial)">
                                                        移&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;除
                                                    </a>
                                                </p>
                                            </div>
                                        </div>
                                        <%--用量集合 dosageList--%>
                                        <!-- /.table-row -->
                                        <div class="table-row clearfix" v-for="skuDosage in projectMaterial.skuDosageList">
                                            <div class="item item-proname" v-if="skuDosage.lossDosage != 0">
                                                <div class="item-inner">
                                                    <div class="goods-item clearfix">
                                                        <span>功能区：{{skuDosage.domainName}}</span>
                                                        <%--<span>损耗系数：{{skuDosage.lossFactor}}</span>--%>
                                                        <span>预算用量：{{skuDosage.budgetDosage}}&nbsp;
                                                            <%--当平米转片时,单位显示为㎡--%>
                                                            <span v-if="skuDosage.convertUnit == 'square_meter_turn'">
                                                                ㎡
                                                            </span>
                                                            <span v-else>
                                                                {{projectMaterial.materialUnit.substring(projectMaterial.materialUnit.indexOf("/")+1, projectMaterial.materialUnit.length)}}
                                                            </span>
                                                        </span>
                                                        <span>含损耗用量：{{skuDosage.lossDosage}}&nbsp;
                                                            <%--当平米转片时,单位显示为片--%>
                                                            <span v-if="skuDosage.convertUnit == 'square_meter_turn'">
                                                                片
                                                            </span>
                                                            <span v-else>
                                                                {{projectMaterial.materialUnit.substring(projectMaterial.materialUnit.indexOf("/")+1, projectMaterial.materialUnit.length)}}
                                                            </span>
                                                        </span>
                                                        <span>用量备注：<font color="#008b8b">{{skuDosage.dosageRemark}}</font> </span>
                                                        <a href="#" class="pull-right" v-if="pageType == 'select' || pageType == 'change'"
                                                           @click="removeSkuDosage(projectMaterial, projectMaterial.skuDosageList, skuDosage)">删除
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /.table-row -->
                                        <div class="table-row clearfix">
                                            <div class="item item-proname">
                                                <div class="item-inner">
                                                    <div class="goods-item">
                                                        <span>预算用量合计：{{projectMaterial.budgetDosageAmount}}&nbsp;
                                                            <%--当平米转片时,单位显示为㎡--%>
                                                            <span v-if="projectMaterial.skuDosageList[0].convertUnit == 'square_meter_turn'">
                                                                ㎡
                                                            </span>
                                                            <span v-else>
                                                                {{projectMaterial.materialUnit.substring(projectMaterial.materialUnit.indexOf("/")+1, projectMaterial.materialUnit.length)}}
                                                            </span>
                                                        </span>
                                                        <span>含损耗用量合计：{{projectMaterial.lossDosageAmount}}&nbsp;
                                                            <%--当平米转片时,单位显示为片--%>
                                                            <span v-if="projectMaterial.skuDosageList[0].convertUnit == 'square_meter_turn'">
                                                                片
                                                            </span>
                                                            <span v-else>
                                                                {{projectMaterial.materialUnit.substring(projectMaterial.materialUnit.indexOf("/")+1, projectMaterial.materialUnit.length)}}
                                                            </span>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /.table-row -->
                                        <div class="table-row clearfix">
                                            <div class="item item-proname">
                                                <div class="item-inner">
                                                    <div class="goods-item"><span>设计备注：<span style="color:#ff9900">{{projectMaterial.designRemark}}</span> </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /.table-row -->
                                        <div class="table-row clearfix">
                                            <div class="item item-proname">
                                                <div class="item-inner">
                                                    <div class="goods-item"><span>审计备注：<span style="color:#FF3030">{{projectMaterial.auditRemark}}</span></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /.table-row -->
                                    </div>

                                    <%--被打回!--%>
                                    <div v-if="projectMaterial.backColorFlag == 'turnBack'" :class="backColorObj.turnBackColor">
                                        <!--商品projectMaterial属性-->
                                        <div class="table-row clearfix" >
                                            <div class="item item-proname clearfix">
                                                <img class="goods-media pull-left" :src="projectMaterial.skuImagePath" alt="商品图" width="80" height="80" />
                                                <div class="item-inner pull-left">
                                                    <div class="goods-title _ellipsis" >
                                                        {{projectMaterial.productName}}
                                                    </div>
                                                    <div class="goods-item _ellipsis4">
                                                        属性: {{projectMaterial.attribute1}}<br>
                                                        属性: {{projectMaterial.attribute2}}<br>
                                                        属性: {{projectMaterial.attribute3}}<br>
                                                        规格: {{projectMaterial.skuSqec}}
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="item item-pay">
                                                <p>
                                                    <input type="text" class="input-num" v-model="projectMaterial.lossDosageAmount" readonly>
                                                    <%--当平米转片时,单位显示为 片--%>
                                                    <span v-if="projectMaterial.skuDosageList[0].convertUnit == 'square_meter_turn'">
                                                        片
                                                    </span>
                                                    <span v-else>
                                                        {{projectMaterial.materialUnit.substring(projectMaterial.materialUnit.indexOf("/")+1, projectMaterial.materialUnit.length)}}
                                                    </span>
                                                </p>
                                                <p>单 价：￥ {{projectMaterial.storeSalePrice}}&nbsp;
                                                    <%--当平米转片时,单位显示为 元/片--%>
                                                    <span v-if="projectMaterial.skuDosageList[0].convertUnit == 'square_meter_turn'">
                                                        元/片
                                                    </span>
                                                    <span v-else>
                                                        {{projectMaterial.materialUnit}}
                                                    </span>
                                                </p>
                                                <p>合 计：<span class="text-red">￥ {{projectMaterial.skuSumMoney}}</span></p>
                                            </div>
                                            <div class="item item-operation">
                                                <p>
                                                    <span v-if="pageType == 'select' || pageType == 'change'">
                                                        <a class="links" href="javascript:;" @click="updateRemark('设计备注', projectMaterial)">设计备注</a>
                                                    </span>
                                                    <span v-if="pageType == 'audit'">
                                                        <a class="links" href="javascript:;" @click="updateRemark('审计备注', projectMaterial)">审计备注</a>
                                                    </span>
                                                </p>
                                            </div>
                                        </div>
                                        <%--用量集合 dosageList--%>
                                        <!-- /.table-row -->
                                        <div class="table-row clearfix" v-for="skuDosage in projectMaterial.skuDosageList">
                                            <div class="item item-proname" v-if="skuDosage.lossDosage != 0">
                                                <div class="item-inner">
                                                    <div class="goods-item clearfix">
                                                        <span>功能区：{{skuDosage.domainName}}</span>
                                                        <%--<span>损耗系数：{{skuDosage.lossFactor}}</span>--%>
                                                        <span>预算用量：{{skuDosage.budgetDosage}}&nbsp;
                                                            <%--当平米转片时,单位显示为㎡--%>
                                                            <span v-if="skuDosage.convertUnit == 'square_meter_turn'">
                                                                ㎡
                                                            </span>
                                                            <span v-else>
                                                                {{projectMaterial.materialUnit.substring(projectMaterial.materialUnit.indexOf("/")+1, projectMaterial.materialUnit.length)}}
                                                            </span>
                                                        </span>
                                                        <span>含损耗用量：{{skuDosage.lossDosage}}&nbsp;
                                                            <%--当平米转片时,单位显示为片--%>
                                                            <span v-if="skuDosage.convertUnit == 'square_meter_turn'">
                                                                片
                                                            </span>
                                                            <span v-else>
                                                                {{projectMaterial.materialUnit.substring(projectMaterial.materialUnit.indexOf("/")+1, projectMaterial.materialUnit.length)}}
                                                            </span>
                                                        </span>
                                                        <span>用量备注：<font color="#008b8b">{{skuDosage.dosageRemark}}</font> </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /.table-row -->
                                        <div class="table-row clearfix">
                                            <div class="item item-proname">
                                                <div class="item-inner">
                                                    <div class="goods-item">
                                                        <span>预算用量合计：{{projectMaterial.budgetDosageAmount}}&nbsp;
                                                            <%--当平米转片时,单位显示为㎡--%>
                                                            <span v-if="projectMaterial.skuDosageList[0].convertUnit == 'square_meter_turn'">
                                                                ㎡
                                                            </span>
                                                            <span v-else>
                                                                {{projectMaterial.materialUnit.substring(projectMaterial.materialUnit.indexOf("/")+1, projectMaterial.materialUnit.length)}}
                                                            </span>
                                                        </span>
                                                        <span>含损耗用量合计：{{projectMaterial.lossDosageAmount}}&nbsp;
                                                            <%--当平米转片时,单位显示为片--%>
                                                            <span v-if="projectMaterial.skuDosageList[0].convertUnit == 'square_meter_turn'">
                                                                片
                                                            </span>
                                                            <span v-else>
                                                                {{projectMaterial.materialUnit.substring(projectMaterial.materialUnit.indexOf("/")+1, projectMaterial.materialUnit.length)}}
                                                            </span>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /.table-row -->
                                        <div class="table-row clearfix">
                                            <div class="item item-proname">
                                                <div class="item-inner">
                                                    <div class="goods-item"><span>设计备注：<span style="color:#ff9900">{{projectMaterial.designRemark}}</span> </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /.table-row -->
                                        <div class="table-row clearfix">
                                            <div class="item item-proname">
                                                <div class="item-inner">
                                                    <div class="goods-item"><span>审计备注：<span style="color:#FF3030">{{projectMaterial.auditRemark}}</span></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /.table-row -->
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </thead>
                </table>

            </div>

        </div>
    </div>
</template>
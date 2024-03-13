/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#include <hilog/log.h>
#include "napi/native_api.h"
#include "math.h"
#include "./common/common.h"

// C++源代码
static napi_value MyHypot(napi_env env, napi_callback_info info) {
    if ((nullptr == env) || (nullptr == info)) {
        OH_LOG_Print(LOG_APP, LOG_ERROR, LOG_PRINT_DOMAIN, "MyHypot", "env or exports is null");
        return nullptr;
    }

    // 参数数量
    size_t argc = PARAMETER_COUNT;

    // 定义参数数组
    napi_value args[PARAMETER_COUNT] = {nullptr};

    // 获取传入的参数并放入参数数组中
    if (napi_ok != napi_get_cb_info(env, info, &argc, args, nullptr, nullptr)) {
        OH_LOG_Print(LOG_APP, LOG_ERROR, LOG_PRINT_DOMAIN, "MyHypot", "api_get_cb_info failed");
        return nullptr;
    }

    // 将传入的参数转化为double类型
    double valueX = 0.0;
    double valueY = 0.0;
    if (napi_ok != napi_get_value_double(env, args[0], &valueX) ||
        napi_ok != napi_get_value_double(env, args[1], &valueY)) {
        OH_LOG_Print(LOG_APP, LOG_ERROR, LOG_PRINT_DOMAIN, "MyHypot", "napi_get_value_double failed");
        return nullptr;
    }

    // 调用C标准库方法hypot计算两数平方的和后计算平方根
    double result = hypot(valueX, valueY);

    // 创建返回结果并返回
    napi_value napiResult;
    // 使用NAPI接口napi_create_double将结果转化为napi_value类型的变量并返回。
    if (napi_ok != napi_create_double(env, result, &napiResult)) {
        OH_LOG_Print(LOG_APP, LOG_ERROR, LOG_PRINT_DOMAIN, "MyHypot", "napi_create_double failed");
        return nullptr;
    }
    return napiResult;
}

// Init方法为Native C++模板生成的结构，开发者可根据实际情况修改其中内容。
EXTERN_C_START
static napi_value Init(napi_env env, napi_value exports) {
    if ((nullptr == env) || (nullptr == exports)) {
        OH_LOG_Print(LOG_APP, LOG_ERROR, LOG_PRINT_DOMAIN, "Init", "env or exports is null");
        return exports;
    }

    // 在napi_property_descriptor desc[]中，我们需要将编写的MyHypot方法与对外提供的接口myHypot接口进行关联，其他参数使用示例默认值填写。
    napi_property_descriptor desc[] = {
        {"myHypot", nullptr, MyHypot, nullptr, nullptr, nullptr, napi_default, nullptr}};
    // 使用Native API接口napi_define_properties构建包含方法对应列表的返回值。
    if (napi_ok != napi_define_properties(env, exports, sizeof(desc) / sizeof(desc[0]), desc)) {
        OH_LOG_Print(LOG_APP, LOG_ERROR, LOG_PRINT_DOMAIN, "Init", "napi_define_properties failed");
        return nullptr;
    }
    return exports;
}
EXTERN_C_END

// 配置模块描述信息，设置Init方法为napi_module的入口方法。
static napi_module demoModule = {
    .nm_version = 1,
    .nm_flags = 0,
    .nm_filename = nullptr,
    .nm_register_func = Init, // napi_module入口方法
    .nm_modname = "hello",    // napi_module模块名
    .nm_priv = ((void *)0),
    .reserved = {0}};

// __attribute__((constructor))修饰的方法由系统自动调用，使用Native API接口napi_module_register()传入模块描述信息进行模块注册。
extern "C" __attribute__((constructor)) void RegisterModule(void) {
    napi_module_register(&demoModule);
}
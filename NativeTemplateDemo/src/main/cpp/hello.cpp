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
// 引入N-API相关头文件。
#include "napi/native_api.h"
#include "math.h"
#include "./common/common.h"

// C++源代码

// 开发者提供的native方法，入参有且仅有如下两个，开发者不需进行变更。
// napi_env 为当前运行的上下文。
// napi_callback_info 记录了一些信息，包括从ArkTS侧传递过来参数等。
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

// 开发者提供的native方法，入参有且仅有如下两个，开发者不需进行变更。
// napi_env 为当前运行的上下文。
// napi_callback_info 记录了一些信息，包括从ArkTS侧传递过来参数等。
static napi_value Add(napi_env env, napi_callback_info info) {
    // 期望从ArkTS侧获取的参数的数量，napi_value可理解为ArkTS value在native方法中的表现形式。
    size_t argc = 2;
    napi_value args[2] = {nullptr};

    // 从info中，拿到从ArkTS侧传递过来的参数，此处获取了两个ArkTS参数，即arg[0]和arg[1]。
    napi_get_cb_info(env, info, &argc, args, nullptr, nullptr);

    // 将获取的ArkTS参数转换为native信息，此处ArkTS侧传入了两个number，这里将其转换为native侧可以操作的double类型。
    double value0;
    napi_get_value_double(env, args[0], &value0);

    double value1;
    napi_get_value_double(env, args[1], &value1);

    // native侧的业务逻辑，这里简单以两数相加为例。
    double nativeSum = value0 + value1;

    // 此处将native侧业务逻辑处理结果转换为ArkTS值，并返回给ArkTS。
    napi_value sum;
    napi_create_double(env, nativeSum, &sum);
    return sum;
}

static napi_value NativeCallArkTS(napi_env env, napi_callback_info info) {
    // 期望从ArkTS侧获取的参数的数量，napi_value可理解为ArkTS value在native方法中的表现形式。
    size_t argc = 1;
    napi_value args[1] = {nullptr};

    // 从info中，拿到从ArkTS侧传递过来的参数，此处获取了一个ArkTS参数，即arg[0]。
    napi_get_cb_info(env, info, &argc, args, nullptr, nullptr);

    // 创建一个ArkTS number作为ArkTS function的入参。
    napi_value argv = nullptr;
    napi_create_int32(env, 10, &argv);

    napi_value result = nullptr;
    // native方法中调用ArkTS function，其返回值保存到result中并返到ArkTS侧。
    napi_call_function(env, nullptr, args[0], 1, &argv, &result);

    return result;
}

// Init方法为Native C++模板生成的结构，开发者可根据实际情况修改其中内容。
EXTERN_C_START
// Init将在exports上挂上Add/NativeCallArkTS这些native方法，此处的exports就是开发者import之后获取到的ArkTS对象。
static napi_value Init(napi_env env, napi_value exports) {
    if ((nullptr == env) || (nullptr == exports)) {
        OH_LOG_Print(LOG_APP, LOG_ERROR, LOG_PRINT_DOMAIN, "Init", "env or exports is null");
        return exports;
    }

    // 在napi_property_descriptor desc[]中，我们需要将编写的MyHypot方法与对外提供的接口myHypot接口进行关联，其他参数使用示例默认值填写。
    // 函数描述结构体，以Add为例，第三个参数"Add"为上述的native方法，第一个参数"add"为ArkTS侧对应方法的名称。
    napi_property_descriptor desc[] = {
        {"myHypot", nullptr, MyHypot, nullptr, nullptr, nullptr, napi_default, nullptr},
        {"add", nullptr, Add, nullptr, nullptr, nullptr, napi_default, nullptr},
        {"nativeCallArkTS", nullptr, NativeCallArkTS, nullptr, nullptr, nullptr, napi_default, nullptr},
    };
    // 使用Native API接口napi_define_properties构建包含方法对应列表的返回值。
    // napi_define_properties: 在exports这个ArkTS对象上，挂载native方法。
    if (napi_ok != napi_define_properties(env, exports, sizeof(desc) / sizeof(desc[0]), desc)) {
        OH_LOG_Print(LOG_APP, LOG_ERROR, LOG_PRINT_DOMAIN, "Init", "napi_define_properties failed");
        return nullptr;
    }
    return exports;
}
EXTERN_C_END

// 配置模块描述信息，设置Init方法为napi_module的入口方法。
// 准备模块加载相关信息，将上述Init函数与本模块名等信息记录下来。
static napi_module demoModule = {
    .nm_version = 1,
    .nm_flags = 0,
    .nm_filename = nullptr,
    .nm_register_func = Init, // napi_module入口方法
    .nm_modname = "hello",    // napi_module模块名
    .nm_priv = ((void *)0),
    .reserved = {0}};

// __attribute__((constructor))修饰的方法由系统自动调用，使用Native API接口napi_module_register()传入模块描述信息进行模块注册。
// 打开so时，该函数将自动被调用，使用上述demoModule模块信息，进行模块注册相关动作。
extern "C" __attribute__((constructor)) void RegisterModule(void) {
    napi_module_register(&demoModule);
}
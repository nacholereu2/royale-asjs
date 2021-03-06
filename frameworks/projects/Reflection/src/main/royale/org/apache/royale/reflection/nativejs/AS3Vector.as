////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
package org.apache.royale.reflection.nativejs {
    
    COMPILE::JS{
        import org.apache.royale.utils.Language
    }
    
    /**
     * Provides data for a stand-in TypeDefinition of the native as3 type for javascript
     */
    COMPILE::JS
    public function AS3Vector(typeName:String='Vector.<*>'):Object{
        var ret:Object= {};
        ret['classRef'] = Language.synthVector(typeName.substring(8, typeName.length - 1));
        ret['name'] = typeName;
        ret['SYNTHETIC_TYPE'] = true;
        
        ret['ROYALE_CLASS_INFO'] = { names: [{ name: typeName, qName: typeName, kind: 'class' }] };
    
        ret['ROYALE_REFLECTION_INFO'] = function():Object {
            return {
                'accessors':function():Object {
                    return {
                        'length':{'access':'readwrite','type':'uint','declaredBy': typeName},
                        'fixed':{'access':'readwrite','type':'Boolean','declaredBy': typeName}
                    };
                },
                'methods':function():Object {
                    var ret:Object = {};
                    //constructor
                    ret[typeName] ={'parameters':function():Object {return [{'index':1,'optional':true,'type':'uint'},{'index':2,'optional':true,'type':'Boolean'}]},'type':'','declaredBy': typeName};
                    return ret;
                }
            };
        };
        if (typeName == 'Vector.<*>') {
            //support for Vector variant subtypes
            ret['variant'] = function(subType:String):Object {
                return AS3Vector(subType);
            };
        }
        
        return ret;
    }
    
}

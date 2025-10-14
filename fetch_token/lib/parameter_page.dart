
import 'package:fetch_token/parameter_model.dart';
import 'package:flutter/material.dart';
import 'package:pms_extends/urlconfigs/api_url_config.dart';
import 'package:pms_pkce_lib/providers/pms_provider.dart';

ApiUrlConfig defaultApiUrlConfig = ApiUrlConfig(
  baseUrl: 'https://example.com',
  apiPath: '/api',
  certData: null,
);

class ParameterPage extends StatefulWidget {
  const ParameterPage({super.key});

  @override
  State<ParameterPage> createState() => _ParameterPageState();
}

class _ParameterPageState extends State<ParameterPage> {
  ParameterModel parameterModel = ParameterModel();//パラメータモデル


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Get token with parameters'),
        // Add your parameter page content here
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Base URL',
          ),
          onChanged: (value) {
            parameterModel.baseUrl = value;
          },
        ),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'API Path',
          ),
          onChanged: (value) {
            parameterModel.clientId = value;
          },
        ),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Token',
          ),
          onChanged: (value) {
            parameterModel.token = value;
          },
        ),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Cert File Path',
          ),
          onChanged: (value) {
            parameterModel.certFilePath = value;
          },
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async {
            ApiUrlConfig config = await parameterModel.convrt();
            // Handle the button press, e.g., save parameters or fetch token
            print('Base URL: ${config.baseUrl}');
            print('API Path: ${config.apiPath}');
            print('Cert Data Length: ${config.certData?.lengthInBytes ?? 0}');
            final authModel=AuthStateModel(pkce:PKCEModel.generate());
            final 
            final provider=PkceAuthenticatorProvider.create();
              postProvider: HttpPostProvider(),
              urlConfig: config,

            );
            provider.
          },
          child: Text('Get    Token'),
        ),
      ],
    );
  }
}
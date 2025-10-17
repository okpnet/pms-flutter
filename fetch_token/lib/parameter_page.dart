
import 'package:fetch_token/models/parameter_model.dart';
import 'package:fetch_token/pkce_proviers_struct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pms_pkce_lib/providers/pms_provider.dart';

/// プロバイダ構造体
final providers= PkceProviersStruct();

ApiUrlConfig defaultApiUrlConfig = ApiUrlConfig(
  baseUrl: 'https://example.com',
  apiPath: '/api',
  certData: null,
);

class ParameterPage extends ConsumerStatefulWidget {
  const ParameterPage({super.key});

  @override
  ParameterPageState createState() => ParameterPageState();
}

class ParameterPageState extends ConsumerState<ParameterPage> {

  @override
  Widget build(BuildContext context) {
    final parameter=ref.watch(providers.parameterModelProvider);
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
            parameter.baseUrl = value;
          },
        ),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'API Path',
          ),
          onChanged: (value) {
            parameter.clientId = value;
          },
        ),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Token',
          ),
          onChanged: (value) {
            parameter.token = value;
          },
        ),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Cert File Path',
          ),
          onChanged: (value) {
            parameter.certFilePath = value;
          },
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async {
            // ApiUrlConfig config = await parameter.convrt();
            // // Handle the button press, e.g., save parameters or fetch token
            // print('Base URL: ${config.baseUrl}');
            // print('API Path: ${config.apiPath}');
            // print('Cert Data Length: ${config.certData?.lengthInBytes ?? 0}');
            // final authModel=AuthStateModel(pkce:PKCEModel.generate());
            // final 
            // final provider=PkceAuthenticatorProvider.create();
            //   postProvider: HttpPostProvider(),
            //   urlConfig: config,

            // );
            // provider.
          },
          child: Text('Get    Token'),
        ),
      ],
    );
  }
}
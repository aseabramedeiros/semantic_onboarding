% ===== KOA Combined Output | contract_id: contrato_ocs_159_2022 =====

% ===== 1) UFO Ontology =====
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE CONTRACT ONTOLOGY EM PROLOG
% Inspirada em UFO-L + UFO-S + Service Contract Ontology (Griffo et al., 2017)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% META-ESTRUTURA (TBox: classes, especializações, relações entre classes)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicados básicos de metamodelo
class(C).          % C é uma classe ontológica
subclass_of(C, P). % C é subclasse de P
disjoint(C1, C2).  % C1 e C2 são disjuntas conceitualmente

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Núcleo UFO-A / UFO-C simplificado
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(agent).           % agente (pessoa, organização etc.)
class(relator).         % relator genérico
class(moment).          % propriedade/momento (trope no sentido do UFO)

class(social_relator).
class(legal_relator).

subclass_of(social_relator, relator).
subclass_of(legal_relator, social_relator).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LEGAL MOMENTS E LEGAL RELATORS (UFO-L)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(legal_moment).
class(legal_entitlement).      % vantagens jurídicas
class(legal_burden_or_lack).  % ônus / falta de prerrogativa

subclass_of(legal_entitlement, legal_moment).
subclass_of(legal_burden_or_lack, legal_moment).

% Tipos de legal relators
class(simple_legal_relator).
class(complex_legal_relator).

subclass_of(simple_legal_relator, legal_relator).
subclass_of(complex_legal_relator, legal_relator).

% ---------------------------------------------------------------------------
% Right / Duty
% ---------------------------------------------------------------------------

class(right).
class(right_to_action).
class(right_to_omission).

class(duty).
class(duty_to_act).
class(duty_to_omit).

subclass_of(right, legal_entitlement).
subclass_of(right_to_action, right).
subclass_of(right_to_omission, right).

subclass_of(duty, legal_burden_or_lack).
subclass_of(duty_to_act, duty).
subclass_of(duty_to_omit, duty).

% ---------------------------------------------------------------------------
% NoRight / Permission
% ---------------------------------------------------------------------------

class(no_right).
class(no_right_to_action).
class(no_right_to_omission).

class(permission).
class(permission_to_act).
class(permission_to_omit).

subclass_of(no_right, legal_burden_or_lack).
subclass_of(no_right_to_action, no_right).
subclass_of(no_right_to_omission, no_right).

subclass_of(permission, legal_entitlement).
subclass_of(permission_to_act, permission).
subclass_of(permission_to_omit, permission).

% ---------------------------------------------------------------------------
% Power / Subjection (Liability)
% ---------------------------------------------------------------------------

class(power).
class(subjection).

subclass_of(power, legal_entitlement).
subclass_of(subjection, legal_burden_or_lack).

% ---------------------------------------------------------------------------
% Disability / Immunity
% ---------------------------------------------------------------------------

class(disability).
class(immunity).

subclass_of(disability, legal_burden_or_lack).
subclass_of(immunity, legal_entitlement).

% ---------------------------------------------------------------------------
% Liberty (liberdade desprotegida como complex legal relator)
% ---------------------------------------------------------------------------

class(liberty_relator).
subclass_of(liberty_relator, complex_legal_relator).

% ---------------------------------------------------------------------------
% Tipos de Simple Legal Relator (pares correlatos)
% ---------------------------------------------------------------------------

class(right_duty_relator).
class(noright_permission_relator).
class(power_subjection_relator).
class(disability_immunity_relator).

subclass_of(right_duty_relator, simple_legal_relator).
subclass_of(noright_permission_relator, simple_legal_relator).
subclass_of(power_subjection_relator, simple_legal_relator).
subclass_of(disability_immunity_relator, simple_legal_relator).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CORRELAÇÃO ENTRE LEGAL MOMENTS (Hohfeld + Alexy)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Correlatos em nível de classe
correlates(right_to_action,   duty_to_act).
correlates(duty_to_act,       right_to_action).

correlates(right_to_omission, duty_to_omit).
correlates(duty_to_omit,      right_to_omission).

correlates(permission_to_act,     no_right_to_action).
correlates(no_right_to_action,    permission_to_act).

correlates(permission_to_omit,    no_right_to_omission).
correlates(no_right_to_omission,  permission_to_omit).

correlates(power,      subjection).
correlates(subjection, power).

correlates(disability, immunity).
correlates(immunity,   disability).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE RELATIONS E SERVICE CONTRACTS (núcleo UFO-S simplificado)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(service_relation).
class(service_agreement).
class(legal_service_agreement).

subclass_of(service_agreement, service_relation).
subclass_of(legal_service_agreement, service_agreement).

% Papéis em relações de serviço
class(service_provider_role).
class(target_customer_role).
class(hired_service_provider_role).
class(service_customer_role).

subclass_of(hired_service_provider_role, service_provider_role).
subclass_of(service_customer_role,       target_customer_role).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE CONTRACT ONTOLOGY (Fig. 4 do artigo)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Em um Legal Service Agreement, cada parte tem Entitlements e Burdens/Lacks
class(hsp_entitlement).      % Hired Service Provider Entitlement
class(hsp_burden_or_lack).   % Hired Service Provider Burden/Lack
class(sc_entitlement).       % Service Customer Entitlement
class(sc_burden_or_lack).    % Service Customer Burden/Lack

subclass_of(hsp_entitlement, legal_entitlement).
subclass_of(sc_entitlement,  legal_entitlement).

subclass_of(hsp_burden_or_lack, legal_burden_or_lack).
subclass_of(sc_burden_or_lack,  legal_burden_or_lack).

% Composição: um Legal Service Agreement é composto de legal moments
% associados a cada papel (provider x customer).
relator_component(legal_service_agreement, hsp_entitlement).
relator_component(legal_service_agreement, hsp_burden_or_lack).
relator_component(legal_service_agreement, sc_entitlement).
relator_component(legal_service_agreement, sc_burden_or_lack).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESQUEMA PARA INSTÂNCIAS (ABox): AGENTES, ACORDOS, CLÁUSULAS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% instance_of(Instancia, Classe).
% Você vai usar isso para criar indivíduos (contratos, cláusulas, agentes...).

:- dynamic instance_of/2.
:- dynamic plays_role/3.
:- dynamic legal_relation_instance/4.
:- dynamic clause_of/2.

% plays_role(Agente, Papel, Acordo).
% Ex.: plays_role(aws, hired_service_provider_role, aws_sns_agreement).
%      plays_role(cliente_x, service_customer_role, aws_sns_agreement).
plays_role(Agent, Role, Agreement).

% clause_of(ClauseId, Agreement).
% ClauseId é uma cláusula (ou grupo de cláusulas) de um acordo específico.
clause_of(ClauseId, Agreement).

% legal_relation_instance(ClauseId, LegalMoment, Bearer, Action).
%
% ClauseId   - identificador da cláusula
% LegalMoment- classe do momento jurídico (duty_to_omit, power, immunity...)
% Bearer     - quem tem esse momento (agente ou papel)
% Action     - ação/omissão ou descrição da conduta
%
% Exemplos (para você popular depois, inspirados no artigo):
% legal_relation_instance(clause_17_1, duty_to_omit, customer, share_service_with_third_parties).
% legal_relation_instance(clause_17_1, right_to_omission, provider, share_service_with_third_parties).

legal_relation_instance(ClauseId, LegalMomentClass, Bearer, Action) :-
    clause_of(ClauseId, _Agreement),
    class(LegalMomentClass),
    (   atom(Bearer)
    ;   plays_role(Bearer, _, _)
    ),
    atom(Action).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REGRAS AUXILIARES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% fecho transitivo de subclass_of/2
subclass_of_trans(C, P) :-
    subclass_of(C, P).
subclass_of_trans(C, P) :-
    subclass_of(C, X),
    subclass_of_trans(X, P).

% is_a(Inst, Classe) — verifica se Inst é instância (direta ou indireta) de Classe
is_a(Inst, Classe) :-
    instance_of(Inst, C0),
    (   C0 = Classe
    ;   subclass_of_trans(C0, Classe)
    ).

% um legal_moment é um entitlement se a classe dele cai abaixo de legal_entitlement
is_entitlement(Inst) :-
    instance_of(Inst, C),
    subclass_of_trans(C, legal_entitlement).

% um legal_moment é um burden/lack se cai abaixo de legal_burden_or_lack
is_burden_or_lack(Inst) :-
    instance_of(Inst, C),
    subclass_of_trans(C, legal_burden_or_lack).

% Dado um LegalMomentClass, encontrar seu correlato (em termos de classe)
correlative_class(LMClass, CorrelateClass) :-
    correlates(LMClass, CorrelateClass).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIM DA ONTOLOGIA BASE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ===== 2) Generated UFO ABox =====
% UFO-only grounding generated from: KOA_Contrato_OCS_159_2022_-_Hardlink_(Suporte_DAS).pl
% contract_id: contrato_ocs_159_2022

instance_of(contrato_ocs_159_2022, legal_service_agreement).

instance_of(banco_nacional_de_desenvolvimento_economico_e_social_bndes, agent).
instance_of(hardlink_informatica_e_sistemas_ltda, agent).

plays_role(banco_nacional_de_desenvolvimento_economico_e_social_bndes, service_customer_role, contrato_ocs_159_2022).
plays_role(hardlink_informatica_e_sistemas_ltda, hired_service_provider_role, contrato_ocs_159_2022).

clause_of(clausula_primeira_objeto, contrato_ocs_159_2022).
clause_of(clausula_segunda_vigencia, contrato_ocs_159_2022).
clause_of(clausula_terceira_local_prazo_condicoes_execucao_objeto, contrato_ocs_159_2022).
clause_of(clausula_quarta_niveis_servico, contrato_ocs_159_2022).
clause_of(clausula_quinta_recebimento_objeto, contrato_ocs_159_2022).
clause_of(clausula_sexta_preco, contrato_ocs_159_2022).
clause_of(clausula_setima_pagamento, contrato_ocs_159_2022).
clause_of(clausula_oitava_equilibrio_economico_financeiro_contrato, contrato_ocs_159_2022).
clause_of(clausula_decima_obrigações_contratado, contrato_ocs_159_2022).
clause_of(clausula_decima_primeira_conduta_etica_contratado_bndes, contrato_ocs_159_2022).
clause_of(clausula_decima_segunda_sigilo_informacoes, contrato_ocs_159_2022).
clause_of(clausula_decima_terceira_acesso_protecao_dados_pessoais, contrato_ocs_159_2022).
clause_of(clausula_decima_terceira_acesso_protecao_dados_pessoais_paragrafo_primeiro, contrato_ocs_159_2022).
clause_of(clausula_decima_terceira_acesso_protecao_dados_pessoais_paragrafo_segundo, contrato_ocs_159_2022).
clause_of(clausula_decima_terceira_acesso_protecao_dados_pessoais_paragrafo_terceiro, contrato_ocs_159_2022).
clause_of(clausula_decima_terceira_acesso_protecao_dados_pessoais_paragrafo_quarto, contrato_ocs_159_2022).
clause_of(clausula_decima_terceira_acesso_protecao_dados_pessoais_paragrafo_quinto, contrato_ocs_159_2022).
clause_of(clausula_decima_terceira_acesso_protecao_dados_pessoais_paragrafo_sexto, contrato_ocs_159_2022).
clause_of(clausula_decima_quarta_obrigações_bndes, contrato_ocs_159_2022).
clause_of(clausula_decima_quinta_equidade_genero_valorizacao_diversidade, contrato_ocs_159_2022).
clause_of(clausula_decima_quinta_equidade_genero_valorizacao_diversidade_paragrafo_primeiro, contrato_ocs_159_2022).
clause_of(clausula_decima_quinta_equidade_genero_valorizacao_diversidade_paragrafo_segundo, contrato_ocs_159_2022).
clause_of(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao, contrato_ocs_159_2022).
clause_of(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao_paragrafo_primeiro, contrato_ocs_159_2022).
clause_of(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao_paragrafo_segundo, contrato_ocs_159_2022).
clause_of(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao_paragrafo_terceiro, contrato_ocs_159_2022).
clause_of(clausula_decima_setima_penalidades, contrato_ocs_159_2022).
clause_of(clausula_decima_oitava_alterações_contratuais, contrato_ocs_159_2022).
clause_of(clausula_decima_nona_extinção_contrato, contrato_ocs_159_2022).
clause_of(clausula_vigesima_disposições_finais, contrato_ocs_159_2022).
clause_of(clausula_vigesima_primeira_foro, contrato_ocs_159_2022).
clause_of(clausula_nona_matriz_riscos, contrato_ocs_159_2022).

legal_relation_instance(clausula_primeira_objeto, duty_to_act, hardlink_informatica_e_sistemas_ltda, provide_technical_support).
legal_relation_instance(clausula_primeira_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_technical_support).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, hardlink_informatica_e_sistemas_ltda, present_manifestation_on_extension).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, hardlink_informatica_e_sistemas_ltda, communicate_interest_in_extension).
legal_relation_instance(clausula_segunda_vigencia, subjection, hardlink_informatica_e_sistemas_ltda, be_subject_to_penalties).
legal_relation_instance(clausula_segunda_vigencia, right_to_omission, hardlink_informatica_e_sistemas_ltda, refuse_to_sign_extension).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, hardlink_informatica_e_sistemas_ltda, execute_object_according_to_specifications).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, expect_execution_according_to_specifications).
legal_relation_instance(clausula_quarta_niveis_servico, duty_to_act, hardlink_informatica_e_sistemas_ltda, execute_services_according_to_standards).
legal_relation_instance(clausula_quarta_niveis_servico, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, stipulate_service_standards).
legal_relation_instance(clausula_quarta_niveis_servico, subjection, hardlink_informatica_e_sistemas_ltda, comply_with_service_standards).
legal_relation_instance(clausula_quarta_niveis_servico, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_price_reduction_indices).
legal_relation_instance(clausula_quarta_niveis_servico, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_service_execution).
legal_relation_instance(clausula_quarta_niveis_servico, subjection, hardlink_informatica_e_sistemas_ltda, accept_price_reduction).
legal_relation_instance(clausula_quinta_recebimento_objeto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_object_receipt).
legal_relation_instance(clausula_quinta_recebimento_objeto, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_object_receipt_power).
legal_relation_instance(clausula_sexta_preco, immunity, banco_nacional_de_desenvolvimento_economico_e_social_bndes, avoid_paying_full_price_if_not_demanded).
legal_relation_instance(clausula_sexta_preco, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, pay_contracted_price).
legal_relation_instance(clausula_sexta_preco, duty_to_act, hardlink_informatica_e_sistemas_ltda, bear_cost_of_errors).
legal_relation_instance(clausula_sexta_preco, subjection, hardlink_informatica_e_sistemas_ltda, receive_reduced_payment).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effectuate_payment).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, hardlink_informatica_e_sistemas_ltda, present_fiscal_document).
legal_relation_instance(clausula_setima_pagamento, right_to_action, hardlink_informatica_e_sistemas_ltda, receive_payment).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, hardlink_informatica_e_sistemas_ltda, provide_supporting_documents).
legal_relation_instance(clausula_setima_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_overpayments).
legal_relation_instance(clausula_setima_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, reject_out_of_time_document).
legal_relation_instance(clausula_setima_pagamento, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, discount_value_from_payment).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, hardlink_informatica_e_sistemas_ltda, provide_cadastro_municipal).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, hardlink_informatica_e_sistemas_ltda, request_price_adjustment).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, hardlink_informatica_e_sistemas_ltda, request_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, initiate_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, convoke_price_negotiation).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, hardlink_informatica_e_sistemas_ltda, provide_information_bndes).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, hardlink_informatica_e_sistemas_ltda, request_price_adjustment_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, rescind_contract).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, negotiate_prices_contracted).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, hardlink_informatica_e_sistemas_ltda, maintain_conditions_of_qualification).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, hardlink_informatica_e_sistemas_ltda, report_penalties).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, hardlink_informatica_e_sistemas_ltda, repair_defects).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, hardlink_informatica_e_sistemas_ltda, repair_damages).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, hardlink_informatica_e_sistemas_ltda, pay_taxes).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, hardlink_informatica_e_sistemas_ltda, assume_responsibility_fiscal_document).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, hardlink_informatica_e_sistemas_ltda, provide_exclusion_simples_nacional).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, hardlink_informatica_e_sistemas_ltda, allow_inspections).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, hardlink_informatica_e_sistemas_ltda, obey_instructions).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, hardlink_informatica_e_sistemas_ltda, designate_representative).
legal_relation_instance(clausula_decima_primeira_conduta_etica_contratado_bndes, duty_to_act, hardlink_informatica_e_sistemas_ltda, maintain_integrity).
legal_relation_instance(clausula_decima_primeira_conduta_etica_contratado_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, maintain_integrity).
legal_relation_instance(clausula_decima_primeira_conduta_etica_contratado_bndes, duty_to_omit, hardlink_informatica_e_sistemas_ltda, offer_undue_advantage).
legal_relation_instance(clausula_decima_primeira_conduta_etica_contratado_bndes, duty_to_omit, hardlink_informatica_e_sistemas_ltda, favor_bndes_employee).
legal_relation_instance(clausula_decima_primeira_conduta_etica_contratado_bndes, duty_to_omit, hardlink_informatica_e_sistemas_ltda, allocate_family_members).
legal_relation_instance(clausula_decima_primeira_conduta_etica_contratado_bndes, duty_to_act, hardlink_informatica_e_sistemas_ltda, prevent_corruption_by_others).
legal_relation_instance(clausula_decima_primeira_conduta_etica_contratado_bndes, duty_to_act, hardlink_informatica_e_sistemas_ltda, observe_policies).
legal_relation_instance(clausula_decima_primeira_conduta_etica_contratado_bndes, duty_to_act, hardlink_informatica_e_sistemas_ltda, remove_agents).
legal_relation_instance(clausula_decima_primeira_conduta_etica_contratado_bndes, duty_to_act, hardlink_informatica_e_sistemas_ltda, communicate_fact_to_bndes).
legal_relation_instance(clausula_decima_primeira_conduta_etica_contratado_bndes, duty_to_act, hardlink_informatica_e_sistemas_ltda, adopt_sustainability_practices).
legal_relation_instance(clausula_decima_segunda_sigilo_informacoes, duty_to_act, hardlink_informatica_e_sistemas_ltda, comply_with_secrecy_rules).
legal_relation_instance(clausula_decima_segunda_sigilo_informacoes, duty_to_act, hardlink_informatica_e_sistemas_ltda, comply_with_bndes_info_security_policy).
legal_relation_instance(clausula_decima_segunda_sigilo_informacoes, duty_to_omit, hardlink_informatica_e_sistemas_ltda, not_access_confidential_info).
legal_relation_instance(clausula_decima_segunda_sigilo_informacoes, duty_to_act, hardlink_informatica_e_sistemas_ltda, maintain_secrecy_of_info).
legal_relation_instance(clausula_decima_segunda_sigilo_informacoes, duty_to_act, hardlink_informatica_e_sistemas_ltda, inform_bndes_of_secrecy_violation).
legal_relation_instance(clausula_decima_segunda_sigilo_informacoes, duty_to_act, hardlink_informatica_e_sistemas_ltda, return_bndes_property).
legal_relation_instance(clausula_decima_segunda_sigilo_informacoes, duty_to_omit, hardlink_informatica_e_sistemas_ltda, not_use_confidential_info).
legal_relation_instance(clausula_decima_segunda_sigilo_informacoes, duty_to_act, hardlink_informatica_e_sistemas_ltda, present_confidentiality_terms).
legal_relation_instance(clausula_decima_segunda_sigilo_informacoes, duty_to_act, hardlink_informatica_e_sistemas_ltda, observe_confidentiality_agreement).
legal_relation_instance(clausula_decima_segunda_sigilo_informacoes, duty_to_act, hardlink_informatica_e_sistemas_ltda, ensure_team_adhesion_to_secrecy).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais, duty_to_act, hardlink_informatica_e_sistemas_ltda, adopt_security_measures).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais, duty_to_act, hardlink_informatica_e_sistemas_ltda, obtain_consent).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais, duty_to_act, hardlink_informatica_e_sistemas_ltda, follow_bndes_instructions).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais, duty_to_act, hardlink_informatica_e_sistemas_ltda, maintain_data_confidentiality).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais, duty_to_act, hardlink_informatica_e_sistemas_ltda, store_data_securely).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais, duty_to_act, hardlink_informatica_e_sistemas_ltda, inform_employees_and_providers).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais, duty_to_act, hardlink_informatica_e_sistemas_ltda, provide_data_access).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais, duty_to_act, hardlink_informatica_e_sistemas_ltda, inform_bndes_of_requests).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais, duty_to_act, hardlink_informatica_e_sistemas_ltda, maintain_data_operations_register).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais, duty_to_act, hardlink_informatica_e_sistemas_ltda, communicate_data_breaches).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais_paragrafo_primeiro, duty_to_act, hardlink_informatica_e_sistemas_ltda, comply_data_protection_law).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais_paragrafo_primeiro, duty_to_act, hardlink_informatica_e_sistemas_ltda, comply_bndes_instructions).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais_paragrafo_primeiro, subjection, hardlink_informatica_e_sistemas_ltda, be_deemed_data_controller).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais_paragrafo_segundo, duty_to_act, hardlink_informatica_e_sistemas_ltda, be_responsible_for_damages).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais_paragrafo_segundo, subjection, hardlink_informatica_e_sistemas_ltda, suffer_penalties).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais_paragrafo_terceiro, duty_to_act, hardlink_informatica_e_sistemas_ltda, obtain_prior_authorization_data_transfer).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais_paragrafo_terceiro, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, authorize_international_data_transfer).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais_paragrafo_quarto, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, request_additional_personal_data).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais_paragrafo_quarto, permission_to_act, hardlink_informatica_e_sistemas_ltda, consent_to_public_data_treatment).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais_paragrafo_quarto, subjection, hardlink_informatica_e_sistemas_ltda, be_subject_to_request_for_data).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais_paragrafo_quarto, duty_to_act, hardlink_informatica_e_sistemas_ltda, provide_additional_personal_data).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais_paragrafo_quinto, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, authorize_personal_data_disclosure).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais_paragrafo_quinto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, disclose_personal_data).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais_paragrafo_quinto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, disclose_personal_data).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais_paragrafo_sexto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, collect_consent_when_necessary).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais_paragrafo_sexto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, inform_data_subjects).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, pay_contracted_party).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, right_to_action, hardlink_informatica_e_sistemas_ltda, receive_payment).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_contract_manager).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, change_contract_manager).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_documents).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, right_to_action, hardlink_informatica_e_sistemas_ltda, request_documents).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_information).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, right_to_action, hardlink_informatica_e_sistemas_ltda, receive_information).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_instructions).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_investigation).
legal_relation_instance(clausula_decima_quinta_equidade_genero_valorizacao_diversidade, duty_to_act, hardlink_informatica_e_sistemas_ltda, comprovar_inexistencia_decisao_administrativa).
legal_relation_instance(clausula_decima_quinta_equidade_genero_valorizacao_diversidade, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, solicitar_comprovacao_inexistencia_decisao).
legal_relation_instance(clausula_decima_quinta_equidade_genero_valorizacao_diversidade, duty_to_act, hardlink_informatica_e_sistemas_ltda, comprovar_inexistencia_sentenca_condenatoria).
legal_relation_instance(clausula_decima_quinta_equidade_genero_valorizacao_diversidade, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, solicitar_comprovacao_inexistencia_sentenca).
legal_relation_instance(clausula_decima_quinta_equidade_genero_valorizacao_diversidade, subjection, hardlink_informatica_e_sistemas_ltda, estar_sujeito_a_solicitacao_bndes).
legal_relation_instance(clausula_decima_quinta_equidade_genero_valorizacao_diversidade, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, poder_solicitar_comprovacao).
legal_relation_instance(clausula_decima_quinta_equidade_genero_valorizacao_diversidade_paragrafo_primeiro, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, suspend_execution_of_contract).
legal_relation_instance(clausula_decima_quinta_equidade_genero_valorizacao_diversidade_paragrafo_primeiro, no_right_to_action, hardlink_informatica_e_sistemas_ltda, demand_execution_while_suspended).
legal_relation_instance(clausula_decima_quinta_equidade_genero_valorizacao_diversidade_paragrafo_segundo, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, verify_contracted_party_status).
legal_relation_instance(clausula_decima_quinta_equidade_genero_valorizacao_diversidade_paragrafo_segundo, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, verify_contracted_party_status).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao, duty_to_omit, hardlink_informatica_e_sistemas_ltda, omit_contract_assignment).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao, no_right_to_action, hardlink_informatica_e_sistemas_ltda, no_right_contract_assignment).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao, duty_to_omit, hardlink_informatica_e_sistemas_ltda, omit_credit_assignment).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao, no_right_to_action, hardlink_informatica_e_sistemas_ltda, no_right_credit_assignment).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao, duty_to_omit, hardlink_informatica_e_sistemas_ltda, omit_issue_credit_title).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao, no_right_to_action, hardlink_informatica_e_sistemas_ltda, no_right_issue_credit_title).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao_paragrafo_primeiro, permission_to_act, hardlink_informatica_e_sistemas_ltda, undertake_corporate_operations).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao_paragrafo_primeiro, duty_to_act, hardlink_informatica_e_sistemas_ltda, obtain_bndes_approval).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao_paragrafo_primeiro, duty_to_act, hardlink_informatica_e_sistemas_ltda, maintain_contractual_conditions).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao_paragrafo_primeiro, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_risks_and_prejudices).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao_paragrafo_segundo, duty_to_act, unknown, execute_contract).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao_paragrafo_segundo, right_to_action, unknown, receive_credits).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao_paragrafo_terceiro, duty_to_omit, hardlink_informatica_e_sistemas_ltda, omit_subcontracting).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao_paragrafo_terceiro, no_right_to_action, hardlink_informatica_e_sistemas_ltda, subcontracting).
legal_relation_instance(clausula_decima_setima_penalidades, subjection, hardlink_informatica_e_sistemas_ltda, be_subject_to_penalties).
legal_relation_instance(clausula_decima_setima_penalidades, right_to_action, hardlink_informatica_e_sistemas_ltda, request_reconsideration).
legal_relation_instance(clausula_decima_setima_penalidades, right_to_action, hardlink_informatica_e_sistemas_ltda, interpose_recourse).
legal_relation_instance(clausula_decima_setima_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, extinguish_contract).
legal_relation_instance(clausula_decima_setima_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalties).
legal_relation_instance(clausula_decima_setima_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalty_with_other_penalties).
legal_relation_instance(clausula_decima_setima_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_credit).
legal_relation_instance(clausula_decima_setima_penalidades, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, bring_judicial_charge).
legal_relation_instance(clausula_decima_oitava_alterações_contratuais, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, agree_to_contract_alteration).
legal_relation_instance(clausula_decima_oitava_alterações_contratuais, subjection, banco_nacional_de_desenvolvimento_economico_e_social_bndes, be_liable_for_damages_from_refusal).
legal_relation_instance(clausula_decima_oitava_alterações_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, answer_for_refusal_damages).
legal_relation_instance(clausula_decima_oitava_alterações_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, formalize_contract_alteration).
legal_relation_instance(clausula_decima_oitava_alterações_contratuais, no_right_to_omission, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_refusal_to_formalize_alteration).
legal_relation_instance(clausula_decima_nona_extinção_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, notify_other_party_of_termination_opportunity_for_defense).
legal_relation_instance(clausula_decima_nona_extinção_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, offer_opportunity_for_defense).
legal_relation_instance(clausula_decima_nona_extinção_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, extinguish_contract_unilaterally).
legal_relation_instance(clausula_vigesima_disposições_finais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, exercise_rights).
legal_relation_instance(clausula_vigesima_disposições_finais, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_strict_compliance).
legal_relation_instance(clausula_vigesima_primeira_foro, subjection, banco_nacional_de_desenvolvimento_economico_e_social_bndes, be_subject_to_rio_de_janeiro_court).
legal_relation_instance(clausula_vigesima_primeira_foro, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, bring_litigation_outside_rio_de_janeiro).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_omit, hardlink_informatica_e_sistemas_ltda, not_request_additives).
legal_relation_instance(clausula_nona_matriz_riscos, no_right_to_action, hardlink_informatica_e_sistemas_ltda, request_additives).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_act, hardlink_informatica_e_sistemas_ltda, respect_economic_financial_balance).
legal_relation_instance(clausula_nona_matriz_riscos, right_to_action, hardlink_informatica_e_sistemas_ltda, receive_adjustment).

% --- Action catalog (local to this contract grounding) ---
action_type(accept_price_reduction).
action_label(accept_price_reduction, 'Accept price reduction').
action_type(adopt_security_measures).
action_label(adopt_security_measures, 'Adopt security measures').
action_type(adopt_sustainability_practices).
action_label(adopt_sustainability_practices, 'Adopt sustainability practices').
action_type(agree_to_contract_alteration).
action_label(agree_to_contract_alteration, 'Agree to contract alteration').
action_type(allocate_family_members).
action_label(allocate_family_members, 'Not allocate family members').
action_type(allow_inspections).
action_label(allow_inspections, 'Allow inspections').
action_type(analyze_risks_and_prejudices).
action_label(analyze_risks_and_prejudices, 'Analyze risks and prejudices').
action_type(answer_for_refusal_damages).
action_label(answer_for_refusal_damages, 'Answer for refusal damages').
action_type(apply_penalties).
action_label(apply_penalties, 'Apply penalties').
action_type(apply_penalty_with_other_penalties).
action_label(apply_penalty_with_other_penalties, 'Apply penalty with other penalties').
action_type(apply_price_reduction_indices).
action_label(apply_price_reduction_indices, 'Apply price reduction indices').
action_type(approve_data_collection).
action_label(approve_data_collection, 'Approve data collection').
action_type(assume_responsibility_fiscal_document).
action_label(assume_responsibility_fiscal_document, 'Assume responsibility for fiscal document').
action_type(authorize_international_data_transfer).
action_label(authorize_international_data_transfer, 'Authorize data transfer').
action_type(authorize_personal_data_disclosure).
action_label(authorize_personal_data_disclosure, 'Authorize data disclosure').
action_type(avoid_paying_full_price_if_not_demanded).
action_label(avoid_paying_full_price_if_not_demanded, 'Avoid paying full price').
action_type(be_deemed_data_controller).
action_label(be_deemed_data_controller, 'Be deemed Data Controller').
action_type(be_liable_for_damages_from_refusal).
action_label(be_liable_for_damages_from_refusal, 'Subject to damages for refusal').
action_type(be_responsible_for_damages).
action_label(be_responsible_for_damages, 'Be responsible for damages').
action_type(be_subject_to_penalties).
action_label(be_subject_to_penalties, 'Be subject to penalties').
action_type(be_subject_to_request_for_data).
action_label(be_subject_to_request_for_data, 'Be subject to data request').
action_type(be_subject_to_rio_de_janeiro_court).
action_label(be_subject_to_rio_de_janeiro_court, 'Subject to Rio de Janeiro court').
action_type(bear_cost_of_errors).
action_label(bear_cost_of_errors, 'Bear cost of errors').
action_type(bring_judicial_charge).
action_label(bring_judicial_charge, 'Bring judicial charge').
action_type(bring_litigation_outside_rio_de_janeiro).
action_label(bring_litigation_outside_rio_de_janeiro, 'No litigation outside Rio').
action_type(change_contract_manager).
action_label(change_contract_manager, 'Change contract manager').
action_type(collect_consent_when_necessary).
action_label(collect_consent_when_necessary, 'Collect consent when necessary').
action_type(communicate_data_breaches).
action_label(communicate_data_breaches, 'Communicate data breaches').
action_type(communicate_fact_to_bndes).
action_label(communicate_fact_to_bndes, 'Communicate fact to BNDES').
action_type(communicate_instructions).
action_label(communicate_instructions, 'Communicate instructions').
action_type(communicate_interest_in_extension).
action_label(communicate_interest_in_extension, 'Communicate interest in extension').
action_type(communicate_investigation).
action_label(communicate_investigation, 'Communicate investigation').
action_type(communicate_penalty).
action_label(communicate_penalty, 'Communicate penalty').
action_type(comply_bndes_instructions).
action_label(comply_bndes_instructions, 'Comply with BNDES instructions').
action_type(comply_data_protection_law).
action_label(comply_data_protection_law, 'Comply with data protection law').
action_type(comply_with_bndes_info_security_policy).
action_label(comply_with_bndes_info_security_policy, 'Comply BNDES security policy').
action_type(comply_with_secrecy_rules).
action_label(comply_with_secrecy_rules, 'Comply with secrecy rules').
action_type(comply_with_security_rules).
action_label(comply_with_security_rules, 'Comply with security rules').
action_type(comply_with_service_standards).
action_label(comply_with_service_standards, 'Comply with standards').
action_type(comprovar_inexistencia_decisao_administrativa).
action_label(comprovar_inexistencia_decisao_administrativa, 'Prove absence of administrative sanction').
action_type(comprovar_inexistencia_sentenca_condenatoria).
action_label(comprovar_inexistencia_sentenca_condenatoria, 'Prove absence of conviction').
action_type(consent_to_public_data_treatment).
action_label(consent_to_public_data_treatment, 'Consent to public data treatment').
action_type(convoke_price_negotiation).
action_label(convoke_price_negotiation, 'Convoke price negotiation').
action_type(deduct_credit).
action_label(deduct_credit, 'Deduct credit').
action_type(deduct_overpayments).
action_label(deduct_overpayments, 'Deduct overpayments').
action_type(demand_execution_while_suspended).
action_label(demand_execution_while_suspended, 'Demand execution while suspended').
action_type(demand_proof_of_regularity).
action_label(demand_proof_of_regularity, 'Demand proof of regularity').
action_type(demand_service_execution).
action_label(demand_service_execution, 'Demand service execution').
action_type(demand_strict_compliance).
action_label(demand_strict_compliance, 'Demand compliance').
action_type(designate_contract_manager).
action_label(designate_contract_manager, 'Designate contract manager').
action_type(designate_representative).
action_label(designate_representative, 'Designate representative').
action_type(disclose_personal_data).
action_label(disclose_personal_data, 'Disclose personal data').
action_type(discount_value_from_payment).
action_label(discount_value_from_payment, 'Discount value from payment').
action_type(effect_object_receipt).
action_label(effect_object_receipt, 'Effect object receipt').
action_type(effect_object_receipt_power).
action_label(effect_object_receipt_power, 'Power to receive object').
action_type(effectuate_payment).
action_label(effectuate_payment, 'Effect payment').
action_type(eliminate_data_at_end).
action_label(eliminate_data_at_end, 'Eliminate data at end').
action_type(ensure_team_adhesion_to_secrecy).
action_label(ensure_team_adhesion_to_secrecy, 'Ensure team adheres to secrecy').
action_type(estar_sujeito_a_solicitacao_bndes).
action_label(estar_sujeito_a_solicitacao_bndes, 'Subject to BNDES request').
action_type(execute_contract).
action_label(execute_contract, 'Execute contract').
action_type(execute_object_according_to_specifications).
action_label(execute_object_according_to_specifications, 'Execute according to specifications').
action_type(execute_services_according_to_standards).
action_label(execute_services_according_to_standards, 'Execute services per standards').
action_type(exercise_rights).
action_label(exercise_rights, 'Exercise rights').
action_type(expect_execution_according_to_specifications).
action_label(expect_execution_according_to_specifications, 'Expect execution as specified').
action_type(extinguish_contract).
action_label(extinguish_contract, 'Extinguish contract').
action_type(extinguish_contract_unilaterally).
action_label(extinguish_contract_unilaterally, 'Terminate contract').
action_type(favor_bndes_employee).
action_label(favor_bndes_employee, 'Not favor BNDES employee').
action_type(follow_bndes_instructions).
action_label(follow_bndes_instructions, 'Follow BNDES instructions').
action_type(formalize_contract_alteration).
action_label(formalize_contract_alteration, 'Formalize contract alteration').
action_type(inform_bndes_of_requests).
action_label(inform_bndes_of_requests, 'Inform BNDES of requests').
action_type(inform_bndes_of_secrecy_violation).
action_label(inform_bndes_of_secrecy_violation, 'Inform BNDES of secrecy breach').
action_type(inform_data_subjects).
action_label(inform_data_subjects, 'Inform data subjects').
action_type(inform_employees_and_providers).
action_label(inform_employees_and_providers, 'Inform employees and providers').
action_type(initiate_price_revision).
action_label(initiate_price_revision, 'Initiate price revision').
action_type(interpose_recourse).
action_label(interpose_recourse, 'Interpose recourse').
action_type(limit_info_access_to_professionals).
action_label(limit_info_access_to_professionals, 'Limit info access to professionals').
action_type(maintain_conditions_of_qualification).
action_label(maintain_conditions_of_qualification, 'Maintain qualification conditions').
action_type(maintain_contractual_conditions).
action_label(maintain_contractual_conditions, 'Maintain contract conditions').
action_type(maintain_data_confidentiality).
action_label(maintain_data_confidentiality, 'Maintain data confidentiality').
action_type(maintain_data_operations_register).
action_label(maintain_data_operations_register, 'Maintain data operations register').
action_type(maintain_integrity).
action_label(maintain_integrity, 'Maintain integrity').
action_type(maintain_secrecy_of_info).
action_label(maintain_secrecy_of_info, 'Maintain secrecy of info').
action_type(negotiate_prices_contracted).
action_label(negotiate_prices_contracted, 'Negotiate prices').
action_type(no_right_contract_assignment).
action_label(no_right_contract_assignment, 'No right to assign contract').
action_type(no_right_credit_assignment).
action_label(no_right_credit_assignment, 'No right to assign credit').
action_type(no_right_issue_credit_title).
action_label(no_right_issue_credit_title, 'No right to issue credit title').
action_type(not_access_confidential_info).
action_label(not_access_confidential_info, 'Not access confidential info').
action_type(not_request_additives).
action_label(not_request_additives, 'Not request additives').
action_type(not_use_confidential_info).
action_label(not_use_confidential_info, 'Not use confidential info').
action_type(notify_other_party_of_termination_opportunity_for_defense).
action_label(notify_other_party_of_termination_opportunity_for_defense, 'Notify termination and defense right').
action_type(obey_instructions).
action_label(obey_instructions, 'Obey instructions').
action_type(observe_confidentiality_agreement).
action_label(observe_confidentiality_agreement, 'Observe confidentiality agreement').
action_type(observe_policies).
action_label(observe_policies, 'Observe BNDES policies').
action_type(obtain_bndes_approval).
action_label(obtain_bndes_approval, 'Obtain BNDES approval').
action_type(obtain_consent).
action_label(obtain_consent, 'Obtain consent').
action_type(obtain_prior_authorization_data_transfer).
action_label(obtain_prior_authorization_data_transfer, 'Obtain prior authorization').
action_type(offer_opportunity_for_defense).
action_label(offer_opportunity_for_defense, 'Offer right to defense').
action_type(offer_undue_advantage).
action_label(offer_undue_advantage, 'Not offer undue advantage').
action_type(omit_contract_assignment).
action_label(omit_contract_assignment, 'Omit contract assignment').
action_type(omit_credit_assignment).
action_label(omit_credit_assignment, 'Omit credit assignment').
action_type(omit_issue_credit_title).
action_label(omit_issue_credit_title, 'Omit issue credit title').
action_type(omit_refusal_to_formalize_alteration).
action_label(omit_refusal_to_formalize_alteration, 'Cannot refuse to formalize alteration').
action_type(omit_subcontracting).
action_label(omit_subcontracting, 'Omit subcontracting').
action_type(pay_contracted_party).
action_label(pay_contracted_party, 'Pay the contracted party').
action_type(pay_contracted_price).
action_label(pay_contracted_price, 'Pay contracted price').
action_type(pay_taxes).
action_label(pay_taxes, 'Pay taxes').
action_type(poder_solicitar_comprovacao).
action_label(poder_solicitar_comprovacao, 'Power to request proof').
action_type(present_confidentiality_terms).
action_label(present_confidentiality_terms, 'Present confidentiality terms').
action_type(present_dif).
action_label(present_dif, 'Present DIF').
action_type(present_fiscal_document).
action_label(present_fiscal_document, 'Present fiscal document').
action_type(present_manifestation_on_extension).
action_label(present_manifestation_on_extension, 'Present manifestation on contract extension').
action_type(prevent_corruption_by_others).
action_label(prevent_corruption_by_others, 'Prevent corruption by others').
action_type(provide_additional_personal_data).
action_label(provide_additional_personal_data, 'Provide additional personal data').
action_type(provide_cadastro_municipal).
action_label(provide_cadastro_municipal, 'Provide cadastro municipal').
action_type(provide_data_access).
action_label(provide_data_access, 'Provide data access').
action_type(provide_documents).
action_label(provide_documents, 'Provide documents').
action_type(provide_exclusion_simples_nacional).
action_label(provide_exclusion_simples_nacional, 'Provide exclusion from Simples Nacional').
action_type(provide_information).
action_label(provide_information, 'Provide information').
action_type(provide_information_bndes).
action_label(provide_information_bndes, 'Provide information to BNDES').
action_type(provide_supporting_documents).
action_label(provide_supporting_documents, 'Provide supporting documents').
action_type(provide_technical_support).
action_label(provide_technical_support, 'Provide technical support').
action_type(receive_adjustment).
action_label(receive_adjustment, 'Receive adjustment').
action_type(receive_credits).
action_label(receive_credits, 'Receive credits').
action_type(receive_information).
action_label(receive_information, 'Receive information').
action_type(receive_payment).
action_label(receive_payment, 'Receive payment').
action_type(receive_reduced_payment).
action_label(receive_reduced_payment, 'Receive reduced payment').
action_type(receive_technical_support).
action_label(receive_technical_support, 'Receive technical support').
action_type(refuse_to_sign_extension).
action_label(refuse_to_sign_extension, 'Refuse to sign contract extension').
action_type(regress_against_contracted_party).
action_label(regress_against_contracted_party, 'Regress against contracted party').
action_type(reject_out_of_time_document).
action_label(reject_out_of_time_document, 'Reject out-of-time document').
action_type(remove_agents).
action_label(remove_agents, 'Remove Agents').
action_type(repair_damages).
action_label(repair_damages, 'Repair damages').
action_type(repair_defects).
action_label(repair_defects, 'Repair defects').
action_type(report_penalties).
action_label(report_penalties, 'Report penalties').
action_type(request_additional_personal_data).
action_label(request_additional_personal_data, 'Request additional personal data').
action_type(request_additives).
action_label(request_additives, 'No right to request additives').
action_type(request_documents).
action_label(request_documents, 'Request documents').
action_type(request_price_adjustment).
action_label(request_price_adjustment, 'Request price adjustment').
action_type(request_price_adjustment_revision).
action_label(request_price_adjustment_revision, 'Request adjustment/revision in time').
action_type(request_price_revision).
action_label(request_price_revision, 'Request price revision').
action_type(request_reconsideration).
action_label(request_reconsideration, 'Request reconsideration').
action_type(rescind_contract).
action_label(rescind_contract, 'Rescind the contract').
action_type(respect_economic_financial_balance).
action_label(respect_economic_financial_balance, 'Respect economic-financial balance').
action_type(return_bndes_property).
action_label(return_bndes_property, 'Return BNDES property').
action_type(return_resources).
action_label(return_resources, 'Return resources').
action_type(solicitar_comprovacao_inexistencia_decisao).
action_label(solicitar_comprovacao_inexistencia_decisao, 'Request proof of no administrative sanction').
action_type(solicitar_comprovacao_inexistencia_sentenca).
action_label(solicitar_comprovacao_inexistencia_sentenca, 'Request proof of no conviction').
action_type(stipulate_service_standards).
action_label(stipulate_service_standards, 'Stipulate service standards').
action_type(store_data_securely).
action_label(store_data_securely, 'Store data securely').
action_type(subcontracting).
action_label(subcontracting, 'No right to subcontract').
action_type(suffer_penalties).
action_label(suffer_penalties, 'Suffer penalties').
action_type(suspend_execution_of_contract).
action_label(suspend_execution_of_contract, 'Suspend execution of contract').
action_type(undertake_corporate_operations).
action_label(undertake_corporate_operations, 'Undertake corporate operations').
action_type(verify_contracted_party_status).
action_label(verify_contracted_party_status, 'Verify contracted party status').

% ===== 3) Original Contract ABox =====
contract(contrato_ocs_159_2022).
contract_metadata(contrato_ocs_159_2022, numero_ocs, '159/2022').
contract_metadata(contrato_ocs_159_2022, numero_sap, '4400005079').
contract_metadata(contrato_ocs_159_2022, tipo_contrato, 'CONTRATO DE PRESTAÇÃO DE SERVIÇOS').
contract_metadata(contrato_ocs_159_2022, partes, ['BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES', 'HARDLINK INFORMÁTICA E SISTEMAS LTDA.']).
contract_metadata(contrato_ocs_159_2022, contratante, 'BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES').
contract_metadata(contrato_ocs_159_2022, cnpj_contratante, '33.657.248/0001-89').
contract_metadata(contrato_ocs_159_2022, contratado, 'HARDLINK INFORMÁTICA E SISTEMAS LTDA.').
contract_metadata(contrato_ocs_159_2022, cnpj_contratado, '04.958.321/0001-54').
contract_metadata(contrato_ocs_159_2022, procedimento_licitatorio, 'Pregão Eletrônico nº 023/2022 - BNDES').
contract_metadata(contrato_ocs_159_2022, data_autorizacao, '06/06/2022').
contract_metadata(contrato_ocs_159_2022, ip_ati_degat, '013/2022').
contract_metadata(contrato_ocs_159_2022, data_ip_ati_degat, '31/05/2022').
contract_metadata(contrato_ocs_159_2022, rubrica_orcamentaria, '3101700021').
contract_metadata(contrato_ocs_159_2022, centro_custo, 'BN00004000').
contract_metadata(contrato_ocs_159_2022, lei_aplicavel, 'Lei nº 13.303/2016').
contract_metadata(contrato_ocs_159_2022, regulamento, 'Regulamento Licitações e Contratos do Sistema BNDES').
contract_clause(contrato_ocs_159_2022, clausula_primeira_objeto, 'CLÁUSULA PRIMEIRA – OBJETO', 'O presente Contrato tem por objeto a prestação de serviços de suporte técnico para 3 (três) equipamentos de Armazenamento de Dados (Direct Attached Storages), conforme especificações constantes do Termo de Referência (Anexo I do Edital do Pregão Eletrônico nº 023/2022 - BNDES) e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_159_2022, clausula_segunda_vigencia, 'CLÁUSULA SEGUNDA – VIGÊNCIA', 'O presente Contrato terá duração de 24 (vinte e quatro) meses, contados a partir de 28/08/2022 ou da data de sua assinatura, o que ocorrer por último, podendo ser prorrogado, mediante aditivo, até o limite total de 60 (sessenta) meses.  Parágrafo Primeiro O CONTRATADO deverá, no prazo de até 5 (cinco) dias úteis, contados da notificação do Gestor do Contrato, apresentar, por intermédio do seu Representante Legal, sua manifestação sobre a prorrogação do Contrato.  Parágrafo Segundo Independente da notificação do parágrafo anterior, o CONTRATADO deverá comunicar ao Gestor seu interesse quanto à prorrogação do contrato até 90 (noventa) dias antes do término de cada período de vigência contratual.  Parágrafo Terceiro A formalização da prorrogação será efetuada por meio de aditivo epistolar, dispensando-se a assinatura do CONTRATADO  Parágrafo Quarto Caso o CONTRATADO se recuse a celebrar aditivo contratual de prorrogação, tendo antes manifestado sua intenção de prorrogar o Contrato ou deixado de manifestar seu propósito de não prorrogar, nos termos do Parágrafo Primeiro desta Cláusula, ficará sujeito às penalidades previstas na Cláusula de Penalidades deste Contrato.').
contract_clause(contrato_ocs_159_2022, clausula_terceira_local_prazo_condicoes_execucao_objeto, 'CLÁUSULA TERCEIRA – LOCAL, PRAZO E CONDIÇÕES DE EXECUÇÃO DO OBJETO', 'A execução do objeto contratado respeitará as especificações constantes do Termo de Referência (Anexo I deste Contrato) e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_159_2022, clausula_quarta_niveis_servico, 'CLÁUSULA QUARTA – NÍVEIS DE SERVIÇO', 'Os serviços contratados deverão ser executados de acordo com os padrões de qualidade, disponibilidade e desempenho estipulados pelo BNDES, observados os níveis de serviço descritos no Anexo I (Termo de Referência) deste Contrato.  Parágrafo Único O descumprimento dos níveis de serviço acarretará a aplicação dos índices de redução do preço previstos no Anexo I (Termo de Referência) deste Contrato, sem prejuízo da aplicação das penalidades previstas neste Contrato, quando cabíveis.').
contract_clause(contrato_ocs_159_2022, clausula_quinta_recebimento_objeto, 'CLÁUSULA QUINTA – RECEBIMENTO DO OBJETO', 'O BNDES efetuará o recebimento do objeto, através do Gestor, mencionado na Cláusula de Obrigações do BNDES deste Contrato, observado o disposto no Anexo I (Termo de Referência) deste Contrato.').
contract_clause(contrato_ocs_159_2022, clausula_sexta_preco, 'CLÁUSULA SEXTA – PREÇO', 'O BNDES pagará ao CONTRATADO, pela execução do objeto contratado, o valor de até R$ 34.747,20 (trinta e quatro mil, setecentos e quarenta e sete reais e vinte centavos), conforme proposta apresentada (Anexo II deste Contrato), observado o disposto na Cláusula de Pagamento deste Instrumento.  Parágrafo Primeiro No valor ajustado no caput desta Cláusula estão incluídos todos os insumos, encargos trabalhistas e tributos, inclusive contribuições fiscais e parafiscais, bem como quaisquer outras despesas necessárias à execução deste Contrato.   Parágrafo Segundo Na hipótese de o objeto ser, a critério do BNDES, parcialmente executado e recebido, os valores previstos nesta Cláusula serão proporcionalmente reduzidos, sem prejuízo da aplicação das penalidades cabíveis.  Parágrafo Terceiro Caso o BNDES não demande o total do objeto previsto neste Contrato, não será devida indenização ao CONTRATADO.   Parágrafo Quarto O CONTRATADO deverá arcar com os ônus decorrentes de eventual equívoco no dimensionamento dos quantitativos de sua proposta, devendo complementá-los, caso os quantitativos previstos inicialmente em sua proposta não sejam satisfatórios para o atendimento ao objeto deste Contrato.').
contract_clause(contrato_ocs_159_2022, clausula_setima_pagamento, 'CLÁUSULA SÉTIMA – PAGAMENTO', 'O BNDES efetuará o pagamento referente ao objeto deste Contrato, mensalmente, por meio de crédito em conta bancária, em até 10 (dez) dias úteis a contar da data de apresentação do documento fiscal ou equivalente legal (prioritariamente  nota fiscal, e nos casos de dispensa da nota fiscal: fatura, boleto bancário com código de barras, recibo de pagamento a autônomo), desde que tenha sido efetuado ateste pelo Gestor do Contrato das obrigações contratuais assumidas pelo CONTRATADO, observado o disposto no Anexo I (Termo de Referência) deste Instrumento.  Parágrafo Primeiro O documento fiscal ou equivalente legal deverá ser apresentado ao BNDES no mês de sua emissão e até o dia 25 (vinte e cinco) do mesmo – ou data anterior que viabilize o tempestivo recolhimento de ISS, se a legislação tributária municipal incidente assim exigir – possibilitando o cumprimento, pelo BNDES, das obrigações fiscais principais e acessórias decorrentes deste Contrato. Havendo impedimento legal para o cumprimento desse prazo, o documento fiscal ou equivalente legal deverá ser apresentado até o primeiro dia útil do mês seguinte da prestação do serviço/fornecimento do bem.   Parágrafo Segundo A apresentação do documento de cobrança fora do prazo previsto nesta cláusula poderá implicar em sua rejeição e no direito do BNDES se ressarcir, preferencialmente, mediante desconto do valor a ser pago ao CONTRATADO, por qualquer penalidade tributária incidente pelo atraso.  Parágrafo Terceiro O primeiro documento fiscal ou equivalente legal terá como objeto de cobrança o período compreendido entre o dia de início da prestação dos serviços e o último dia desse mês, e os documentos fiscais ou equivalentes legais subsequentes terão como referência o período compreendido entre o primeiro e o último dia de cada mês. O último documento fiscal ou equivalente legal, por seu turno, referir-se-á ao período compreendido entre o primeiro dia do último mês da prestação dos serviços e o último dia de serviço prestado. Em todos os casos, o documento fiscal ou equivalente legal só poderá ser emitido e apresentado ao BNDES após a efetiva prestação do serviço, respeitado o disposto no Parágrafo anterior.  Parágrafo Quarto Para toda efetivação de pagamento, o Contratado deverá encaminhar o documento fiscal ou equivalente em meio digital para caixa postal eletrônica ou protocolar em sistema eletrônico próprio do BNDES, considerando as orientações do Contratante vigentes na ocasião do pagamento. No caso de emissão de documento fiscal exclusivamente em meio físico o mesmo deverá ser encaminhado ao protocolo do BNDES para devido registro de recebimento.  Parágrafo Quinto O documento fiscal ou equivalente legal deverá respeitar a legislação tributária e conter, minimamente, as seguintes informações: I. número da Ordem de Compra/Serviço – OCS; II. número SAP do Contrato; III. número do pedido SAP, a ser informado pelo Gestor do Contrato; IV. número da Folha de Registro de Serviços (FRS), a ser informado pelo Gestor do Contrato; V. descrição detalhada do objeto executado e dos respectivos valores; VI. período de referência da execução do objeto; VII. nome e número do CNPJ do CONTRATADO, cuja regularidade fiscal tenha sido avaliada na fase de habilitação, bem como o número de inscrição na Fazenda Municipal e/ou Estadual, conforme o caso; VIII. nome, telefone e e-mail do responsável pelo documento fiscal ou equivalente legal; IX. nome e número do banco e da agência, bem como o número da conta corrente do CONTRATADO, vinculada ao CNPJ constante do documento fiscal ou equivalente legal, com respectivos dígitos verificadores; X. tomador do serviço: Banco Nacional de Desenvolvimento Econômico e Social – BNDES; XI. CNPJ do tomador do serviço: 33.657.248/0001-89; XII. local de execução do objeto, emitindo-se um documento fiscal ou equivalente legal para cada Município em que o serviço seja prestado, se for o caso;  XIII. código do serviço, nos termos da lista anexa à Lei Complementar nº 116/2003, em concordância com as informações inseridas na Declaração de Informações para Fornecimento - DIF;  XIV. número de inscrição do contribuinte individual válido junto ao INSS (NIT ou PIS/PASEP); e XV. destaque das retenções tributárias aplicáveis, conforme estabelecido na DIF.  Parágrafo Sexto Os pagamentos a serem efetuados em favor do CONTRATADO estarão sujeitos, no que couber, às retenções de tributos, nos termos da legislação tributária e com base nas informações prestadas pelo CONTRATADO. Em casos de dispensa ou benefício fiscal que implique em redução ou eliminação da retenção de tributos, o CONTRATADO fornecerá todos os documentos comprobatórios.  Parágrafo Sétimo Caso o CONTRATADO emita documento fiscal ou equivalente legal autorizado por Município diferente daquele onde se localiza o estabelecimento do BNDES tomador do serviço e destinatário da cobrança, deverá providenciar o cadastro junto à Secretaria Municipal de Fazenda ou órgão equivalente do Município do estabelecimento tomador, salvo quando se aplicar uma das exceções constantes dos incisos do artigo 3º da Lei Complementar Federal nº 116/03.  A inexistência desse cadastro ou o cadastro em item diverso do faturado não constitui impeditivo ao processo de pagamento, mas um ônus a ser suportado pelo CONTRATADO, uma vez que o BNDES está obrigado a reter na fonte a quantia equivalente ao ISS dos serviços faturados, conforme legislação aplicável.  Parágrafo Oitavo O documento fiscal ou equivalente legal emitido pelo CONTRATADO deverá estar em conformidade com a legislação do Município onde o CONTRATADO esteja estabelecida, cuja regularidade fiscal foi avaliada na etapa de habilitação, e com as normas regulamentares aprovadas pela Secretaria da Receita Federal do Brasil, especialmente no que tange à retenção de tributos, sob pena de devolução do documento e interrupção do prazo para pagamento.   Parágrafo Nono Ao documento fiscal ou equivalente legal deverão ser anexados: I. certidões de regularidade fiscal exigidas na fase de habilitação; II. comprovante de que o CONTRATADO é optante do Simples Nacional, se for o caso; III. em caso de isenção/imunidade tributária, documentos comprobatórios com a indicação do dispositivo legal que ampara a isenção/imunidade; e IV. demais documentos solicitados pelo Gestor do Contrato, necessários ao pagamento do objeto contratado;  Parágrafo Décimo Caso sejam verificadas divergências, o BNDES devolverá o documento fiscal ou equivalente legal ao CONTRATADO ou solicitará a emissão de carta de correção, quando cabível, interrompendo-se o prazo de pagamento até que este providencie as medidas saneadoras ou comprove a correção dos dados contestados pelo BNDES.   Parágrafo Décimo Primeiro Além de outras hipóteses previstas em lei ou no Contrato, o BNDES poderá descontar, do montante expresso no documento fiscal ou equivalente legal, os valores referentes a multas, indenizações apuradas em processo administrativo, bem como qualquer obrigação que decorra do descumprimento da legislação pelo CONTRATADO.  Parágrafo Décimo Segundo Caso o BNDES não efetue o pagamento na forma prevista nesta Cláusula, em decorrência de fato não atribuível ao CONTRATADO, aos valores devidos serão acrescidos juros de mora de 0,5% (meio por cento) ao mês, pro rata tempore, calculados desde o dia do vencimento até a data da efetiva liquidação.  Parágrafo Décimo Terceiro Fica assegurado ao BNDES o direito de deduzir do pagamento devido ao CONTRATADO, por força deste Contrato ou de outro contrato mantido com o BNDES, o valor correspondente aos pagamentos efetuados a maior ou em duplicidade.').
contract_clause(contrato_ocs_159_2022, clausula_oitava_equilibrio_economico_financeiro_contrato, 'CLÁUSULA OITAVA – EQUILÍBRIO ECONÔMICO-FINANCEIRO DO CONTRATO', 'O BNDES e o CONTRATADO têm direito ao equilíbrio econômico-financeiro do Contrato, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, a ser realizado mediante reajuste ou revisão de preços.  Parágrafo Primeiro O reajuste de preços, na forma prevista na legislação, poderá ser requerido pelo CONTRATADO a cada período de 12 (doze) meses, sendo o primeiro contado do dia 22/06/2022, data de apresentação da proposta (Anexo II deste Contrato), e os seguintes, do fato gerador anterior, adotando-se para tanto a aplicação do Índice de Custo de Tecnologia da Informação – ICTI acumulado, sobre o preço referido na Cláusula de Preço deste Instrumento.  Parágrafo Segundo A revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação do CONTRATADO, quando ocorrer fato imprevisível ou previsível, porém, de consequências incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado ao CONTRATADO nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte: I. o CONTRATADO deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; II. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da proposta ou do último reajuste e do momento do pedido de revisão; e III. com o requerimento, o CONTRATADO deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da proposta ou do último reajuste e o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado.  Parágrafo Terceiro Independentemente de solicitação, o BNDES poderá convocar o CONTRATADO para negociar a redução dos preços, mantendo o mesmo objeto contratado, na quantidade e nas especificações indicadas na proposta, em virtude da redução dos preços de mercado, ou de itens que compõem o custo, cabendo ao CONTRATADO apresentar as informações solicitadas pelo BNDES.   Parágrafo Quarto O CONTRATADO deverá solicitar o reajuste e/ou a revisão de preços até a prorrogação ou o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que: I. caso o fato gerador do reajuste e/ou da revisão de preços ou a divulgação do índice de reajuste ocorra com antecedência inferior a 60 (sessenta) dias da prorrogação ou do encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste e/ou a revisão de preços; II. caso a assinatura do aditivo de prorrogação torne superveniente a ocorrência do fato gerador do reajuste, ou a divulgação do índice de reajuste ocorra após a prorrogação ou o encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste de preços; III. o BNDES deverá analisar o pedido de reajuste e/ou revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pelo CONTRATADO dos comprovantes de variação dos custos, ficando este prazo suspenso, a critério do BNDES, enquanto o CONTRATADO não apresentar a documentação solicitada para a comprovação da variação de custos; e IV. caso o CONTRATADO não solicite o reajuste e/ou revisão de preços nos prazos fixados acima, não fará jus aos efeitos retroativos ou, caso o Contrato esteja encerrado, operar-se-á a renúncia a eventual direito ao reajuste e/ou à revisão.  Parágrafo Quinto Se o processo de reajuste e/ou revisão de preços não for concluído até o vencimento do Contrato, e este for prorrogado, sua continuidade após o reequilíbrio econômico-financeiro ficará condicionada à manutenção da proposta do CONTRATADO como a condição mais vantajosa para o BNDES, podendo este: I. realizar negociação de preços junto ao CONTRATADO, de forma a viabilizar a continuidade do ajuste, quando os novos valores fixados após o reajuste e/ou a revisão de preços estiverem acima do patamar apurado no mercado; ou  II. rescindir o Contrato, mediante aviso prévio ao CONTRATADO, com antecedência de 30 (trinta) dias, quando resultar infrutífera a negociação indicada no inciso anterior.  Parágrafo Sexto Na ocorrência da hipótese prevista no inciso II do Parágrafo anterior, o CONTRATADO fará jus à integralidade dos valores apurados no processo de reajuste e/ou revisão de preços até o término do Contrato, não podendo, todavia, reclamar qualquer indenização em razão da rescisão do mesmo.').
contract_clause(contrato_ocs_159_2022, clausula_nona_matriz_riscos, 'CLÁUSULA NONA – MATRIZ DE RISCOS', 'O BNDES e o CONTRATADO, tendo como premissa a obtenção do melhor custo contratual mediante a alocação do risco à parte com maior capacidade para geri-lo e absorvê-lo, identificam os riscos decorrentes da relação contratual e, sem prejuízo de outras previsões contratuais, estabelecem os respectivos responsáveis na Matriz de Riscos constante do Anexo IV deste Contrato.   Parágrafo Primeiro O reajuste de preço aludido na Matriz de Riscos deve respeitar o disposto na
contract_clause(contrato_ocs_159_2022, clausula_decima_obrigações_contratado, 'CLÁUSULA DÉCIMA – OBRIGAÇÕES DO CONTRATADO', 'Além de outras obrigações estabelecidas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do CONTRATADO: I. manter durante a vigência deste Contrato todas as condições de habilitação e a ausência de impedimentos exigidas quando da contratação, comprovando-as sempre que solicitado pelo BNDES; II. comunicar a imposição de penalidade que acarrete o impedimento de contratar com o BNDES, bem como a eventual perda dos pressupostos para a licitação; III. reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total ou em parte, o objeto do Contrato em que se verificarem vícios, defeitos ou incorreções decorrentes da execução ou de materiais empregados; IV. reparar todos os danos e prejuízos causados ao BNDES ou a terceiros, não restando excluída ou reduzida esta responsabilidade pela presença de fiscalização ou pelo acompanhamento da execução por parte do Gestor do Contrato; V. pagar todos os encargos e tributos, que incidam ou venham a incidir, direta ou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer momento, exigir do CONTRATADO a comprovação de sua regularidade; VI. assumir a responsabilidade integral por quaisquer ônus que venham a ser impostos ao BNDES em virtude de documento fiscal que seja emitido em desacordo com a legislação aplicável; VII. providenciar, perante a Receita Federal do Brasil - RFB, comprovando ao BNDES, sua exclusão obrigatória do Simples Nacional, no prazo estipulado pelo artigo 30 da Lei Complementar nº 123/2006, se o CONTRATADO, quando optante: a) extrapolar o limite de receita bruta anual previsto no artigo 3º da Lei Complementar nº 123/2006, ao longo da vigência deste Contrato; ou b) enquadrar-se em alguma das situações previstas no artigo 17 da Lei Complementar nº 123/2006; VIII. permitir vistorias e acompanhamento da execução do objeto pelo Gestor do Contrato; IX. obedecer às instruções e aos procedimentos, estabelecidos pelo BNDES, para a adequada execução do Contrato; X. designar 01 (um) preposto como responsável pelo Contrato firmado com o BNDES, para participar de eventuais reuniões e ser o interlocutor do CONTRATADO, zelando pelo fiel cumprimento das obrigações previstas neste Instrumento; XI. apresentar, em até 10 dias úteis após a convocação, a Declaração de Informações para Fornecimento - DIF, adequadamente preenchida, sob pena de instauração de procedimento punitivo para aplicação de penalidade, e de retenção tributária, pelo BNDES, nos casos previstos em lei, da alíquota que entender adequada; a) as informações inseridas na Declaração de Informações para Fornecimento – DIF não deverão divergir das constantes do documento fiscal ou equivalente legal; XII.   responsabilizar-se pelo cumprimento das normas de segurança das dependências do BNDES por parte dos profissionais alocados na execução dos serviços, quanto ao porte de identificação e à utilização dos acessos indicados pelo BNDES; XIII. devolver recursos disponibilizados pelo BNDES, revogar perfis de acesso de seus profissionais, eliminar suas caixas postais e adotar demais providências aplicáveis ao término da vigência deste Contrato.').
contract_clause(contrato_ocs_159_2022, clausula_decima_primeira_conduta_etica_contratado_bndes, 'CLÁUSULA DÉCIMA PRIMEIRA– CONDUTA ÉTICA DO CONTRATADO E DO BNDES', 'O CONTRATADO e o BNDES comprometem-se a manter a integridade nas relações público-privadas, agindo de boa-fé e de acordo com os princípios da moralidade administrativa e da impessoalidade, além de pautar sua conduta por preceitos éticos e, em especial, por sua responsabilidade socioambiental.  Parágrafo Primeiro Em atendimento ao disposto no caput desta Cláusula, o CONTRATADO obriga-se, inclusive, a: I. não oferecer, prometer, dar, autorizar, solicitar ou aceitar, direta ou indiretamente, qualquer vantagem indevida, seja pecuniária ou de outra natureza, consistente em fraude, ato de corrupção ou qualquer outra violação de dever legal, relacionada com este Contrato, bem como a tomar todas as medidas ao seu alcance para impedir administradores, empregados, agentes, representantes, fornecedores, contratados ou subcontratados, seus ou de suas controladas, de fazê-lo; II. impedir o favorecimento ou a participação de empregado ou dirigente do Sistema BNDES (BNDES e suas subsidiárias) na execução do objeto do presente Contrato; III. providenciar para que não sejam alocados, na execução dos serviços, familiares de dirigente ou empregado do Sistema BNDES, considerando-se familiar o cônjuge, o companheiro ou o parente em linha reta ou colateral, por consanguinidade ou afinidade, até o terceiro grau; IV. observar a Política para Transações com Partes Relacionadas e o Código de Ética do Sistema BNDES vigentes ao tempo da contratação, bem como a Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES e a Política Corporativa Anticorrupção do Sistema BNDES, assegurando-se de que seus representantes, administradores e todos os profissionais envolvidos na execução do objeto pautem seu comportamento e sua atuação pelos princípios neles constantes; e V. adotar, na execução dos serviços, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de redução da poluição.  Parágrafo Segundo O BNDES recomenda, ao CONTRATADO, considerar em suas práticas de gestão a implantação de programa de integridade estruturado, voltado à prevenção, detecção e remediação da ocorrência de fraudes e atos de corrupção.  Parágrafo Terceiro Verificada uma das situações mencionadas nos incisos II e III do Parágrafo Primeiro desta Cláusula, compete ao CONTRATADO afastar imediatamente da execução do Contrato os agentes que impliquem a ocorrência dos impedimentos e favorecimentos aludidos, além de comunicar tal fato ao BNDES, sem prejuízo de apuração de sua responsabilidade, caso tenha agido de má-fé.  Parágrafo Quarto O CONTRATADO declara ter conhecimento do Código de Ética do Sistema BNDES, bem como da Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES e da Política Corporativa Anticorrupção do Sistema BNDES, que poderão ser consultados por intermédio do sítio eletrônico www.bndes.gov.br ou requisitados ao Gestor do Contrato.   Parágrafo Quinto Eventuais irregularidades ou descumprimentos das normas internas do BNDES ou da legislação vigente podem ser denunciados à Ouvidoria por qualquer cidadão através dos seguintes canais: página na internet (www.bndes.gov.br/ouvidoria); correio (Caixa Postal 15054, CEP 20031-120, Rio de Janeiro – RJ); e telefone (0800 702 6307).').
contract_clause(contrato_ocs_159_2022, clausula_decima_segunda_sigilo_informacoes, 'CLÁUSULA DÉCIMA SEGUNDA – SIGILO DAS INFORMAÇÕES', 'Cabe ao CONTRATADO cumprir as seguintes regras de sigilo e assegurar a aceitação e adesão às mesmas por profissionais que integrem ou venham a integrar a sua equipe na prestação do objeto deste Contrato, as quais perdurarão, inclusive, após a cessação do vínculo contratual e da prestação dos serviços: I. cumprir as diretrizes e normas da Política Corporativa de Segurança da Informação do BNDES, necessárias para assegurar a integridade e o sigilo das informações;  II. não acessar informações sigilosas do BNDES, salvo quando previamente autorizado por escrito; III. sempre que tiver acesso às informações mencionadas no inciso anterior: a) manter sigilo dessas informações, não podendo copiá-las, reproduzi-las, retê-las ou praticar qualquer outra forma de uso que não seja imprescindível para a adequada prestação do objeto deste Contrato; b) limitar o acesso às informações aos profissionais envolvidos na prestação dos serviços objeto deste Contrato, os quais deverão estar cientes da natureza sigilosa das informações e das obrigações e responsabilidades decorrentes do uso dessas informações; e c) informar imediatamente ao BNDES qualquer violação das regras de sigilo ora estabelecidas que tenha ocorrido por sua ação ou omissão, independentemente da existência de dolo, bem como dos profissionais envolvidos, adotando todas as orientações do BNDES para remediar a violação; IV. entregar ao BNDES, ao término da vigência deste Contrato, todo e qualquer material de propriedade deste, inclusive notas pessoais envolvendo matéria sigilosa e registro de documentos de qualquer natureza que tenham sido criados, usados ou mantidos sob seu controle ou posse, assumindo o compromisso de não utilizar qualquer informação sigilosa a que teve acesso no âmbito deste Contrato;  V. apresentar, antes do início da prestação dos serviços, Termos de Confidencialidade, conforme minuta constante do Anexo V (Minuta de Termo de Confidencialidade para Profissionais) deste Contrato, assinados pelos profissionais que acessarão informações sigilosas, devendo referida obrigação ser também cumprida por ocasião de substituição desses profissionais; e VI. observar o disposto no Termo de Confidencialidade assinado por seu Representante Legal constante do Anexo IV (Termo de Confidencialidade para Representante Legal) deste Contrato.').
contract_clause(contrato_ocs_159_2022, clausula_decima_terceira_acesso_protecao_dados_pessoais, 'CLÁUSULA DÉCIMA TERCEIRA– ACESSO E PROTEÇÃO DE DADOS PESSOAIS', 'As partes assumem o compromisso de proteger os direitos fundamentais de liberdade e de privacidade, relativos ao tratamento de dados pessoais, nos meios físicos e digitais, devendo, para tanto, adotar medidas corretas de segurança sob o aspecto técnico, jurídico e administrativo, e observar que:   I. Eventual tratamento de dados em razão do presente Contrato deverá ser realizado conforme os parâmetros previstos na legislação, especialmente na Lei n° 13.709/2018 – Lei Geral de Proteção de Dados - LGPD, dentro de propósitos legítimos, específicos, explícitos e informados ao titular;  II. O tratamento será limitado às atividades necessárias ao atingimento das finalidades contratuais e, caso seja necessário, ao cumprimento de suas obrigações legais ou regulatórias, sejam de ordem principal ou acessória, observando-se que, em caso de necessidade de coleta de dados pessoais, esta será realizada mediante prévia aprovação do BNDES, responsabilizando-se o CONTRATADO por obter o consentimento dos titulares, salvo nos casos em que a legislação dispense tal medida; III. O CONTRATADO deverá seguir as instruções recebidas do BNDES em relação ao tratamento de dados pessoais; IV. O CONTRATADO se responsabilizará como “Controlador de dados” no caso do tratamento de dados para o cumprimento de suas obrigações legais ou regulatórias, devendo obedecer aos parâmetros previstos na legislação; V. Os dados coletados somente poderão ser utilizados pelas partes, seus representantes, empregados e prestadores de serviços diretamente alocados na execução contratual, sendo que, em hipótese alguma, poderão ser compartilhados ou utilizados para outros fins, sem a prévia autorização do BNDES, ou caso haja alguma ordem judicial, observando-se as medidas legalmente previstas para tanto; VI. O CONTRATADO deve manter a confidencialidade dos dados pessoais obtidos em razão do presente contrato, devendo adotar as medidas técnicas e administrativas adequadas e necessárias, visando assegurar a proteção dos dados, nos termos do artigo 46 da LGPD, de modo a garantir um nível apropriado de segurança e a prevenção e mitigação de eventuais riscos; VII. Os dados deverão ser armazenados de maneira segura pelo CONTRATADO, que utilizará recursos de segurança da informação e tecnologia adequados, inclusive quanto a mecanismos de detecção e prevenção de ataques cibernéticos e incidentes de segurança da informação.  VIII. O CONTRATADO dará conhecimento formal para seus empregados e/ou prestadores de serviço acerca das disposições previstas nesta Cláusula e na Cláusula de Sigilo das Informações, responsabilizando-se por eventual uso indevido dos dados pessoais, bem como por quaisquer falhas nos sistemas por ela empregados para o tratamento dos dados. IX. O BNDES possui direito de regresso em face do CONTRATADO em razão de eventuais danos causados por este em decorrência do descumprimento das responsabilidades e obrigações previstas no âmbito deste contrato e da Lei Geral de Proteção de Dados Pessoais; X. O CONTRATADO deverá disponibilizar ao titular do dado um canal ou sistema em que seja garantida consulta facilitada e gratuita sobre a forma, a duração do tratamento e a integralidade de seus dados pessoais. XI. O CONTRATADO deverá informar imediatamente ao BNDES todas as solicitações recebidas em razão do exercício dos direitos pelo titular dos dados relacionados a este Contrato, seguindo as orientações fixadas pelo BNDES e pela legislação em vigor para o adequado endereçamento das demandas. XII. O CONTRATADO deverá manter registro de todas as operações de tratamento de dados pessoais que realizar no âmbito do Contrato disponibilizando, sempre que solicitado pelo BNDES, as informações necessárias à produção do Relatório de Impacto de Dados Pessoais, disposto no artigo 5º, XVII, da Lei Geral de Proteção de Dados Pessoais. XIII. Qualquer incidente que implique em violação ou risco de violação ou vazamento de dados pessoais deverá ser prontamente comunicado ao BNDES, informando-se também todas as providências adotadas e os dados pessoais eventualmente afetados, cabendo ao CONTRATADO disponibilizar as informações e documentos solicitados e colaborar com qualquer investigação ou auditoria que venha a ser realizada. XIV. Ao final da vigência do Contrato, o CONTRATADO deverá eliminar de sua base de informações todo e qualquer dado pessoal que tenha tido acesso em razão da execução do objeto contratado, salvo quando tenha que manter a informação para o cumprimento de obrigação legal.').
contract_clause(contrato_ocs_159_2022, clausula_decima_terceira_acesso_protecao_dados_pessoais_paragrafo_primeiro, 'Parágrafo Primeiro', 'As Partes reconhecem que, se durante a execução do Contrato armazenarem, coletarem, tratarem ou de qualquer outra forma processarem dados pessoais, no sentido dado pela legislação vigente aplicável, o BNDES será considerado “Controlador de Dados”, e o CONTRATADO “Operador” ou “Processador de Dados”, salvo nas situações expressas em contrário nesse Contrato. Contudo, caso o CONTRATADO descumpra as obrigações prevista na legislação de proteção de dados ou as instruções do BNDES, será equiparado a “Controlador de Dados”, inclusive para fins de sua responsabilização por eventuais danos causados.').
contract_clause(contrato_ocs_159_2022, clausula_decima_terceira_acesso_protecao_dados_pessoais_paragrafo_segundo, 'Parágrafo Segundo', 'Caso o CONTRATADO disponibilize dados de terceiros, além das obrigações no caput desta Cláusula, deve se responsabilizar por eventuais danos que o BNDES venha a sofrer em decorrência de uso indevido de dados pessoais por parte do CONTRATADO, sempre que ficar comprovado que houve falha de segurança técnica e administrativa, descumprimento de regras previstas na legislação de proteção à privacidade e dados pessoais, e das orientações do BNDES, sem prejuízo das penalidades deste contrato.').
contract_clause(contrato_ocs_159_2022, clausula_decima_terceira_acesso_protecao_dados_pessoais_paragrafo_terceiro, 'Parágrafo Terceiro', 'A transferência internacional de dados deve se dar em caráter excepcional e na estrita observância da legislação, especialmente, dos artigos 33 a 36 da Lei n° 13.709/2018 e nos normativos do Banco Central do Brasil relativos ao processamento e armazenamento de dados das instituições financeiras, e dependerá de autorização prévia do BNDES ao CONTRATADO.').
contract_clause(contrato_ocs_159_2022, clausula_decima_terceira_acesso_protecao_dados_pessoais_paragrafo_quarto, 'Parágrafo Quarto', 'A assinatura deste Contrato importa na manifestação de inequívoco consentimento do titular, seja ele pessoa física direta ou indiretamente relacionada ao CONTRATADO, inclusive sócios, representantes legais, empregados, contratados e/ou terceirizados, quando for o caso, dos dados pessoais que tenham se tornados públicos como condição para participação na licitação e para contratação, para tratamento pelo BNDES, na forma da Lei nº 13.709/2018. Poderão ser solicitados pelo BNDES dados pessoais adicionais a fim de viabilizar o cumprimento de obrigação legal.').
contract_clause(contrato_ocs_159_2022, clausula_decima_terceira_acesso_protecao_dados_pessoais_paragrafo_quinto, 'Parágrafo Quinto', 'Os representantes legais signatários do presente autorizam a divulgação dos dados pessoais expressamente contidos nos documentos decorrentes do procedimento de licitação, tais como nome, CPF, e-mail, telefone e cargo, para fins de publicidade das contratações administrativas no site institucional do BNDES e em cumprimento à Lei nº 12.527/ 2011 (Lei de Acesso à Informação).').
contract_clause(contrato_ocs_159_2022, clausula_decima_terceira_acesso_protecao_dados_pessoais_paragrafo_sexto, 'Parágrafo Sexto', 'As partes comprometem-se a coletar o consentimento, quando necessário, conforme previsto na Lei no 13.709/2018 (Lei Geral de Proteção de Dados-LGPD), bem como informar os titulares dos dados pessoais mencionados no presente instrumento, para as finalidades descritas no parágrafo acima.').
contract_clause(contrato_ocs_159_2022, clausula_decima_quarta_obrigações_bndes, 'CLÁUSULA DÉCIMA QUARTA– OBRIGAÇÕES DO BNDES', 'Além de outras obrigações estipuladas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do BNDES: I. realizar os pagamentos devidos ao CONTRATADO, nas condições estabelecidas neste Contrato; II. designar, como Gestor do Contrato, Eduardo Carneiro da Cunha, que atualmente exerce a função de Coordenador de Serviços da ATI/DESET/GINF, a quem caberá o acompanhamento, a fiscalização e a avaliação da execução dos serviços, bem como a liquidação da despesa e o atestado de cumprimento das obrigações assumidas; III. designar, como substituto do Gestor do Contrato, para atuar em sua eventual ausência, Gedir Fabiano de Moraes Gonçalves, que atualmente exerce a função de Analista de Sistemas da ATI/DESET/GINF;  IV. alterar, quando conveniente, o Gestor do Contrato e/ou o seu substituto, por outro profissional, mediante comunicação escrita ao CONTRATADO; V. fornecer ao CONTRATADO, quando solicitado ao Gestor do Contrato, cópia do Código de Ética do Sistema BNDES, da Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES, da Política Corporativa Anticorrupção do Sistema BNDES e da Política Corporativa de Segurança da Informação do BNDES; VI. colocar à disposição do CONTRATADO todas as informações necessárias à perfeita execução dos serviços objeto deste Contrato; e VII. comunicar ao CONTRATADO, por escrito:  a) quaisquer instruções ou procedimentos sobre assuntos relacionados ao Contrato; b) a abertura de procedimento administrativo para a apuração de condutas irregulares do CONTRATADO, concedendo-lhe prazo para defesa; e c) a aplicação de eventual penalidade, nos termos deste Contrato.').
contract_clause(contrato_ocs_159_2022, clausula_decima_quinta_equidade_genero_valorizacao_diversidade, 'CLÁUSULA DÉCIMA QUINTA– EQUIDADE DE GÊNERO E VALORIZAÇÃO DA DIVERSIDADE', 'O CONTRATADO deverá comprovar, sempre que solicitado pelo BNDES, a inexistência de decisão administrativa final sancionadora, exarada por autoridade ou órgão competente, em razão da prática de atos, pelo próprio CONTRATADO ou dirigentes, administradores ou sócios majoritários, que importem em discriminação de raça ou gênero, trabalho infantil ou trabalho escravo, e de sentença condenatória transitada em julgado, proferida em decorrência dos referidos atos, e, se for o caso, de outros que caracterizem assédio moral ou sexual e importem em crime contra o meio ambiente.').
contract_clause(contrato_ocs_159_2022, clausula_decima_quinta_equidade_genero_valorizacao_diversidade_paragrafo_primeiro, 'Parágrafo Primeiro', 'Na hipótese de ter havido decisão administrativa e/ou sentença condenatória, nos termos referidos no caput desta Cláusula, a execução do objeto contratual poderá ser suspensa pelo BNDES até a comprovação do cumprimento da reparação imposta ou da reabilitação do CONTRATADO ou de seus dirigentes, conforme o caso.').
contract_clause(contrato_ocs_159_2022, clausula_decima_quinta_equidade_genero_valorizacao_diversidade_paragrafo_segundo, 'Parágrafo Segundo', 'A comprovação a que se refere o caput desta Cláusula será realizada por meio de declaração, sem prejuízo da verificação do sistema informativo interno do BNDES – Sistema de Gerenciamento do Cadastro de Entidades (N02), acerca da inexistência de sanção em face do CONTRATADO e/ou de seus dirigentes, administradores ou sócios majoritários que impeça a contratação.').
contract_clause(contrato_ocs_159_2022, clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao, 'CLÁUSULA DÉCIMA SEXTA – CESSÃO DE CONTRATO OU DE CRÉDITO, SUCESSÃO CONTRATUAL E SUBCONTRATAÇÃO', 'É vedada a cessão deste Contrato, total ou parcialmente, ou de qualquer crédito dele decorrente, bem como a emissão, por parte do CONTRATADO, de qualquer título de crédito em razão do mesmo.').
contract_clause(contrato_ocs_159_2022, clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao_paragrafo_primeiro, 'Parágrafo Primeiro', 'É admitida a sucessão contratual nas hipóteses em que o CONTRATADO realizar as operações societárias de fusão, cisão ou incorporação, condicionada aos seguintes requisitos: I. aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos decorrentes de tal alteração contratual; e II. manutenção de todas as condições contratuais e requisitos de habilitação originais.').
contract_clause(contrato_ocs_159_2022, clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao_paragrafo_segundo, 'Parágrafo Segundo', 'Caso ocorra a sucessão contratual admitida no Parágrafo anterior, o sucessor assumirá integralmente a posição do sucedido, passando a ser responsável pela execução do presente Contrato, fazendo jus, por conseguinte, ao recebimento dos créditos dele decorrentes.').
contract_clause(contrato_ocs_159_2022, clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao_paragrafo_terceiro, 'Parágrafo Terceiro', 'É vedada a subcontratação para a execução do objeto deste Contrato.').
contract_clause(contrato_ocs_159_2022, clausula_decima_setima_penalidades, 'CLÁUSULA DÉCIMA SÉTIMA– PENALIDADES', 'Em caso de inexecução total ou parcial do Contrato, inclusive de descumprimento de exigência expressamente formulada pelo BNDES ou de inobservância de qualquer obrigação legal, bem como em caso de mora, sem motivo justificado, o CONTRATADO ficará sujeito às seguintes penalidades: I. advertência; II. multa, de acordo com o Anexo I (Termo de Referência); e III. suspensão temporária de participação em licitação e impedimento de contratar com o BNDES, por prazo não superior a 2 (dois) anos, apurado de acordo com a gravidade da infração.  Parágrafo Primeiro As penalidades serão aplicadas observadas as normas do Regulamento de Licitações e Contratos do SISTEMA BNDES.   Parágrafo Segundo  Contra a decisão de aplicação de penalidade, o CONTRATADO poderá requerer a reconsideração para a decisão de advertência, ou interpor o recurso cabível para as demais penalidades, na forma e no prazo previstos no Regulamento de Licitações e Contratos do SISTEMA BNDES.  Parágrafo Terceiro  A imposição de penalidade prevista nesta Cláusula não impede a extinção do Contrato pelo BNDES, nos termos da legislação aplicável e da Cláusula de Extinção do Contrato.   Parágrafo Quarto  A multa poderá ser aplicada juntamente com as demais penalidades.  Parágrafo Quinto  A multa aplicada ao CONTRATADO e os prejuízos causados ao BNDES serão deduzidos de quaisquer créditos a ele devidos, ressalvada a possibilidade de cobrança judicial da diferença eventualmente não coberta pelos mencionados créditos.  Parágrafo Sexto  No caso de atos lesivos à Administração Pública, nacional ou estrangeira, observar-se-ão os termos da Lei nº 12.846/2013.  Parágrafo Sétimo A celebração de Termo de Ajustamento de Conduta prevista no Regulamento de Licitações e Contratos do Sistema BNDES não importa em renúncia às penalidades prevista neste Contrato e no Anexo I (Termo de Referência).  Parágrafo Oitavo A sanção prevista no inciso III desta Cláusula também poderá ser aplicada às sociedades ou profissionais que: I. tenham sofrido condenação definitiva por praticarem, por meios dolosos, fraude fiscal no recolhimento de quaisquer tributos; II. tenham praticado atos ilícitos visando frustrar os objetivos da licitação; III. demonstrem não possuir idoneidade para contratar com o BNDES em virtude de atos ilícitos praticados.').
contract_clause(contrato_ocs_159_2022, clausula_decima_oitava_alterações_contratuais, 'CLÁUSULA DÉCIMA OITAVA– ALTERAÇÕES CONTRATUAIS', 'O presente Contrato poderá ser alterado, por acordo entre as partes, nas hipóteses disciplinadas no art. 81 da Lei nº 13.303/2016, entre outras legal ou contratualmente previstas, observando-se que:  I. as alterações devem preservar o equilíbrio econômico-financeiro do Contrato; e II. é vedada a modificação contratual que desnature o objeto da contratação ou afete as condições essenciais previstas no Termo de Referência (Anexo I deste Contrato).  Parágrafo Primeiro Em atenção aos princípios que regem as relações contratuais, nas hipóteses em que for imprescindível a alteração deste Contrato para viabilizar sua plena execução, conforme demonstrado em processo administrativo, não caberá a recusa das partes à respectiva formalização, salvo em caso de justo motivo, devidamente comprovado pela parte que o alegar.  Parágrafo Segundo       A parte que, injustificadamente, se recusar a promover a alteração contratual indicada no Parágrafo anterior, deverá responder pelos danos eventualmente causados, sem prejuízo das demais consequências previstas neste Instrumento e na legislação vigente.     Parágrafo Terceiro As alterações contratuais serão formalizadas mediante instrumento aditivo, ressalvadas as hipóteses legais que admitem a alteração por apostilamento, os ajustes necessários à eventual correção de erros materiais ou à alteração de dados acessórios do Contrato e alterações de preços decorrentes decorrente de reajuste, repactuação ou revisão de preços causada por alterações na legislação tributária, que poderão ser celebrados por meio epistolar.').
contract_clause(contrato_ocs_159_2022, clausula_decima_nona_extinção_contrato, 'CLÁUSULA DÉCIMA NONA – EXTINÇÃO DO CONTRATO', 'O presente Contrato poderá ser extinto de acordo com as hipóteses previstas na legislação, e ainda: I. Consensualmente, formalizada em autorização escrita e fundamentada do BNDES, mediante aviso prévio por escrito, com antecedência mínima de 90 (noventa) dias ou de prazo menor a ser negociado pelas partes à época da rescisão; II. em razão do inadimplemento total ou parcial de qualquer de suas obrigações, cabendo à parte inocente notificar a outra por escrito, assinalando-lhe prazo razoável para o cumprimento das obrigações, quando o mesmo não for previamente fixado neste instrumento ou em seus anexos; II. na ausência de liberação, por parte do BNDES, de área, local ou objeto necessário para a sua execução, nos prazos contratuais; III. em virtude da suspensão da execução do Contrato, por ordem escrita do BNDES, por prazo superior a 120 (cento e vinte) dias ou ainda por repetidas suspensões que totalizem o mesmo prazo;  IV. quando for decretada a falência do CONTRATADO; V. caso o CONTRATADO perca uma das condições de habilitação exigidas quando da contratação; VI. na hipótese de descumprimento do previsto na Cláusula de Cessão de Contrato ou de Crédito, Sucessão Contratual e Subcontratação; VII. caso o CONTRATADO seja declarada inidônea pela União, por Estado ou pelo Distrito Federal;  VIII. em função da suspensão do direito de o CONTRATADO licitar ou contratar com o BNDES; IX. na hipótese de caracterização de ato lesivo à Administração Pública, nos termos da Lei nº 12.846/2013, cometido pelo CONTRATADO no processo de contratação ou por ocasião da execução contratual; X. em razão da dissolução do CONTRATADO;  XI. quando da ocorrência de caso fortuito ou de força maior, regularmente comprovado, impeditivo da execução do Contrato.  Parágrafo Primeiro Caracteriza inadimplemento das obrigações de pagamento pecuniário do presente Contrato, a mora superior a 90 (noventa) dias.   Parágrafo Segundo Os casos de extinção contratual convencionados no caput desta Cláusula deverão ser precedidos de notificação escrita à outra parte do Contrato, e de oportunidade de defesa, dispensada a necessidade de interpelação judicial.').
contract_clause(contrato_ocs_159_2022, clausula_vigesima_disposições_finais, 'CLÁUSULA VIGÉSIMA – DISPOSIÇÕES FINAIS', 'Este Contrato representa todo o acordo entre as partes com relação ao objeto nele previsto.   Parágrafo Primeiro Integram o presente Contrato: Anexo I - Termo de Referência Anexo II - Proposta Anexo III - Matriz de Risco Anexo IV - Termo de Confidencialidade para Representante Legal Anexo V - Minuta de Termo de Confidencialidade para Profissionais  Parágrafo Segundo A omissão ou tolerância quanto à exigência do estrito cumprimento das obrigações contratuais ou ao exercício de prerrogativa decorrente deste Contrato não constituirá renúncia ou novação nem impedirá as partes de exercerem os seus direitos a qualquer tempo.').
contract_clause(contrato_ocs_159_2022, clausula_vigesima_primeira_foro, 'CLÁUSULA VIGÉSIMA PRIMEIRA– FORO', 'É competente o foro da cidade do Rio de Janeiro para solucionar eventuais litígios decorrentes deste Contrato, afastado qualquer outro, por mais privilegiado que seja.   As folhas deste contrato foram conferidas por Necesio Antonio Krapp Tavares, advogado do BNDES, por autorização do representante legal que o assina.  As partes consideram, para todos os efeitos, a data da última assinatura digital como a da formalização jurídica deste instrumento.   E, por estarem assim justos e contratados, firmam o presente Instrumento, juntamente com as testemunhas abaixo     _____________________________________________________________________ BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES     _____________________________________________________________________ HARDLINK INFORMÁTICA E SISTEMAS LTDA.                Testemunhas:    _________________________________ _________________________________                                                                                                                                                                            Assinado digitalmente por  Bruno Calvão de Abreu 2022.07.05 12:52:29 -03\'00\'ANDREA FERREIRA FOSSATI:96082305000Assinado de forma digital por ANDREA FERREIRA FOSSATI:96082305000 Dados: 2022.07.07 18:18:48 -03\'00\'MARIO MOKICHI HASHIBA:10471533866Assinado de forma digital por MARIO MOKICHI HASHIBA:10471533866 Dados: 2022.07.07 18:27:43 -03\'00\'DIOGO MORENO PEREIRA GOMES:09278449741Assinado de forma digital por DIOGO MORENO PEREIRA GOMES:09278449741 Dados: 2022.07.08 16:11:54 -03\'00\'FERNANDO PASSERI LAVRADO:00486757765Assinado de forma digital por FERNANDO PASSERI LAVRADO:00486757765 Dados: 2022.07.11 18:36:27 -03\'00\'').

% ===== END =====
